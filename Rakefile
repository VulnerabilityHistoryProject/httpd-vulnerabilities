# require 'irb'
# require 'nokogiri'
# require 'open-uri'
# require 'optparse'
# require 'zlib'
require 'rspec/core/rake_task'
require 'yaml'
require_relative 'scripts/cve_spec'
require_relative 'scripts/cve_helper'

desc 'Run the specs by default'
task default: :check_new_cves

#RSpec::Core::RakeTask.new(:spec)

#namespace :syntax do

  desc 'Use cve_spec and cve_helper to check incoming cve*** yaml files'
  task :check_new_cves do
    puts "Reading the ymls..."
    ruby scripts/cve_spec.rb
  end
#end