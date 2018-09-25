require 'rspec/core/rake_task'
require 'yaml'
require_relative 'scripts/cve_spec'

desc 'Run the specs by default'
task default: :spec

RSpec::Core::RakeTask.new(:spec)

namespace :cve do

  desc 'Use cve_spec and cve_helper to check incoming cve*** yaml files'
  task :check_new_cves do
    puts "Reading the ymls..."
    ruby 'scripts/cve_spec.rb'
  end
end
