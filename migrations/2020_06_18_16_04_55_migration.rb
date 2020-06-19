require 'yaml'
require 'json'
require 'open3'
require 'byebug'

# MIGRATION STATUS: Not done yet.
# raise 'Migration already performed.' # Don't run this migration. Kept for posterity

# INSTRUCTIONS
# Clone the HTTPD mirror from GitHub as tmp/src.
# Make sure you have the latest VHP shepherd tools installed
# Run this from the top of the repo.

@gitlog_json = JSON.parse(File.read('commits/gitlog.json'))

def order_of_keys
  %w(
    CVE
    yaml_instructions
    curated_instructions
    curated
    reported_instructions
    reported
    announced_instructions
    announced
    published_instructions
    published
    description_instructions
    description
    bounty_instructions
    bounty
    reviews
    bugs
    repo
    fixes_vcc_instructions
    fixes
    vccs
    upvotes_instructions
    upvotes
    unit_tested
    discovered
    autodiscoverable
    specification
    subsystem
    interesting_commits
    i18n
    ipc
    lessons
    mistakes
    CWE_instructions
    CWE
    CWE_note
    nickname_instructions
    nickname
  )
end

def commit_exists?(sha)
  stdout, stderr, status = Open3.capture3("git -C ./tmp/src show #{sha} -- ")
  return true if stderr.strip.empty?
  return false if stderr.match? /fatal: bad object/
  # Otherwise... uh oh
  warn "ERROR looking up #{sha} failed. See message below. Skipping commit"
  warn "ERROR Original git message: #{stderr}"
  return true
end

# Sometimes Apache HTTPD updates their
def update_commitlist(h)
  h.map do |entry|
    sha = entry["commit"].to_s.strip
    n = entry["note"]
    # First, try to look it up in our existing repo
    if commit_exists?(sha) || sha.empty?
      entry # do nothing, put it back in the hash
    else
      # Ok, we know it doesn't exist. Now look it up in gitlog.json
      if @gitlog_json.key? sha
        m = @gitlog_json[sha]["message"]
        svn_id = m.lines.select {|l| l.match? /git-svn-id/ }.join.strip
        grep_cmd = <<~EOS.strip
          git -C ./tmp/src rev-list --all --grep="#{svn_id}" --
        EOS
        stdout, stderr, status = Open3.capture3(grep_cmd)
        if stderr.empty?
          {
            "commit" => stdout.strip,
            "note" => <<~EOS.strip
              #{entry["note"].to_s.lines.join("\n")}

              Formerly #{sha} before HTTPD rewrote Git history.
            EOS
          }
        else
          warn "ERROR getting commit #{sha}. #{stderr}"
          entry
        end
      else
        warn "ERROR commit #{sha} does not exist in gitlog.json"
        entry
      end
    end
  end
end

ymls = Dir['cves/*.yml'] + ['skeletons/cve.yml']
ymls.each do |yml_file|
  h = YAML.load(File.open(yml_file, 'r').read)

  # Do stuff to your hash here.
  h["fixes"] = update_commitlist(h["fixes"])
  # h[:vccs] = update_commitlist(h[:vccs])
  # h[:interesting_commits][:commits] = update_commitlist(h[:interesting_commits][:commits])



  # Reconstruct the hash in the order we specify
  out_h = {}
  order_of_keys.each do |key|
    out_h[key] = h[key]
  end

  # Generate the new YML, clean it up, write it out.
  File.open(yml_file, "w+") do |file|
    yml_txt = out_h.to_yaml[4..-1] # strip off ---\n
    stripped_yml = ""
    yml_txt.each_line do |line|
      stripped_yml += "#{line.rstrip}\n" # strip trailing whitespace
    end
    file.write(stripped_yml)
    print '.'
  end
end
puts 'Done!'
