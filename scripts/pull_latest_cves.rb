require 'mechanize'
require_relative 'helpers'

class PullLatestCVEs
  def httpd_security_pages
    %w(
      http://httpd.apache.org/security/vulnerabilities_24.html
      http://httpd.apache.org/security/vulnerabilities_22.html
      http://httpd.apache.org/security/vulnerabilities_20.html
      http://httpd.apache.org/security/vulnerabilities_13.html
    )
  end

  def is_cve?(link)
    link.href.include? "cve.mitre.org"
  end

  def get_cve(link)
    link.href.upcase.match( /(?<cvekey>CVE-[\-\d]+)/ )[:cvekey]
  end

  def crawl(url)
    puts "Crawling #{url}"
    cves = []
    Mechanize.new.get(url) do |page|
      cur_cve = 'REPLACEME'
      page.links.each do | link |
        if is_cve?(link)
          cves << get_cve(link)
        end
      end
    end
    return cves
  end

  def save(cves)
    cves.each do |cve|
      next if cve_yaml_exists?(cve)
      ymlstr = cve_skeleton_yml.sub("CVE:\n", "CVE: #{cve}\n")
      File.open(as_filename(cve), 'w+') { |f| f.write(ymlstr) }
      puts "Saved #{as_filename(cve)}"
    end
  end

  def run
    cves = []
    httpd_security_pages.each do |url|
      cves = (cves + crawl(url)).flatten.uniq
    end
    save cves
  end

end

# This is a standalone script
PullLatestCVEs.new.run
