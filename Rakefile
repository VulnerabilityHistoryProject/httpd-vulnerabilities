require 'rspec/core/rake_task'
require 'yaml'
require 'csv'
require 'open3'
require_relative 'spec/cve_spec.rb'
require_relative 'scripts/git_log_utils.rb'
require_relative 'scripts/list_cve_data.rb'
require_relative 'scripts/script_helpers.rb'


desc 'Run the specs by default'
task default: :spec

RSpec::Core::RakeTask.new(:spec)

namespace :cve do

  desc 'Use cve_spec and cve_helper to check incoming cve*** yaml files'
  task :check_new_cves do
    puts "Reading the ymls..."
    ruby 'cve_spec'
  end
end

namespace :git do
  workingDir = "#{ENV['GIT_REPOSITORY']}";
  desc "Clone the HTTPD repo into #{workingDir}"
  task :clone do
    workingDir = "#{ENV['GIT_REPOSITORY']}";
    cloneCommand = "git clone https://github.com/apache/httpd.git"
    if workingDir.to_s.empty?
      workingDir = "./tmp"
      cloneCommand = cloneCommand + " src"
    end
    puts "Cloning httpd git repo..."
    Dir.chdir(workingDir) do
      puts `#{cloneCommand}`
    end
  end
end

namespace :list do
  desc 'Use Git to list all of the files that were fixed from a vulnerability'
  task :vulnerable_files do
    puts "Getting fixes from ymls..."
    tmpFixes = ListCVEData.new.get_fixes
    fixes = []
    puts "Getting files from git"
    gitRepository = "#{ENV['GIT_REPOSITORY']}"
    outputFile = "#{ENV['OUTPUT_FILE']}"
    gitStart = "#{ENV['GIT_START']}"
    gitEnd = "#{ENV['GIT_END']}"
    if gitRepository.to_s.empty?
      gitRepository = "./tmp/src"
    end
    if outputFile.to_s.empty?
      outputFile = './tmp/httpd-vulnerable-files.csv'
    end    
    if gitStart.to_s.empty? && gitEnd.to_s.empty?
      fixes = tmpFixes
    else
      Dir.chdir(gitRepository) do
        tmpFixes.each do |fix|
          gitLogCommand = "git log --before=#{gitStart} "+'--pretty=format:"%H" ' + fix + ' -1'
          check = `#{gitLogCommand}`
          if fix.to_s == check.chomp.to_s
            #ignore this CVE/fix since it took place BEFORE our start period
          else
            fixes << fix
          end
        end
      end
    end
    
    files = GitLogUtils.new(gitRepository).get_files_from_shas(fixes)
    CSV.open(outputFile, 'w+') do |csv|
      csv << [ 'filepath' ]
      files.to_a.each { |f| csv << [f] }
    end
  end

  desc 'Output newline delimited list of git fixes for every CVE'
  task :fixes do
    ListCVEData.new.print_fixes
  end

  desc 'Output newline delimited list of CVE missing fix data'
  task :missing_fixes do
    ListCVEData.new.print_missing_fixes
  end

end
