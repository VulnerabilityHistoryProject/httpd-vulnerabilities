# GOAL: Take historicall GIT fixes and VCC commits and insert them
# 	into their correct CVEs
#
# 	STEPS:
# 	1) Read in csv_file and load cve,git_vcc,git_fix (line by line)
# 	2) Open cve_file read in by line
# 	3) Write new cve_file.yml with new data inserted

require 'yaml'
require 'csv'
# outut from CSV counter revealed that '157' entries exist to add
cve_names = Array.new
git_vccs  = Array.new
git_fixes = Array.new

# read in csv data about CVE info to add to skeleton files
CSV.foreach('cve-parsing/csv_files/vcc-output.csv') do |row|
	  #puts "CVE_NAME: "  + row[0]
	  #puts "GIT_VCCs: "  + row[1]
	  #puts "GIT_FIXES: " + row[2]
	  cve_names << row[0]
	  git_vccs  << row[1]
	  git_fixes << row[2]
end

# iterate over cve_names array and modify each yaml file as they occur

cve_yml = YAML.load_file('cve-parsing/new-cve-skeleton.yml')
for index in 0...(cve_names.size - 1)
	puts "CVE_NAME: #{cve_names[index]}"
	if File.exists? ('../cve-copies/#{cve_names[index]}.yml')
		puts cve_names[index]	
	end

end

