require 'yaml'
require 'csv'

# MIGRATION STATUS: Done.
raise 'Migration already performed.' # Don't run this. Kept for posterity

def order_of_keys
  %w(
    CVE
    yaml_instructions
    curated_instructions
    curated
    reported_instructions
    reported_date
    announced_instructions
    announced_date
    published_instructions
    published_date
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
    sandbox
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

def source_code?(path)
  return !path.start_with?('docs/') &&
         !path.end_with?('.txt') &&
         !path.end_with?('.html')
end

Dir['cves/*.yml'].each do |yml_file|
    h = YAML.load(File.open(yml_file, 'r').read)

    # Excavate VCCs using archeogit
    # Need to have archeogit repo a sibling of this repo's directory
    # You'll need to set up the configuration.json there too.
    h['vccs'] = []
    vcc_commits = {}
    fix_commits = h['fixes'].inject([]) do |arr, fix|
      arr << fix['commit'] unless fix['commit'].to_s.empty?
      arr
    end

    fix_commits.each do |f|
      # puts "#{yml_file} - #{f}"
      Dir.chdir('../archeogit') do
        cmd = "archeogit blame --csv ../django-vulnerabilities/tmp/src #{f}"
        out = `#{cmd}`
        CSV.new(out, headers: true).each do |row|
          if (row['commit'] != row['contributor']) && source_code?(row['path'])
            vcc_commits[row['contributor']] = true # set
          end

        end
      end
    end
    vcc_commits.keys.each do |vcc|
      h['vccs'] << {
        "commit" => vcc,
        "note" => "This VCC was discovered automatically via archeogit."
      }
    end

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
