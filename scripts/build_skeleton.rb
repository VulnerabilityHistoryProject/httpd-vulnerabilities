# HTTPD Skeleton Builder
#
require 'yaml'
# require 'csv'

# Requirements: A cve is passed to this script via command line args for a cve to be made with it

# Step 1: get name of file and open for writing [USE COMMAND LINE ARGS FOR THIS!!!]
# Step 2: build cve YML object
# Step 3: Write cve info to file


def get_skeleton_file(filenameAndPath)	
	if File.exists?(filenameAndPath)
		puts("[INFO] YAML file loaded: #{filenameAndPath}") 
		return filenameAndPath
	else
		puts("Skeleton File did not load...")
		exit
	end
end


def get_cve_name()
	# read command line args for the cve
end


def build_skeleton(skeleton_file, cve_input)
	skeleton_cve_object = YAML.load(get_skeleton_file(skeleton_file))
	puts skeleton_cve_object
	#print cwe instructions

	#cwe

	#curated instructions

	#curated flag -> set to false

	#print announced instructions
	
	#announced
	
	#print description instructions
	
	#description
	
	#print bounty instuctions
	
	#bounty
	
end



# Main
# read command line arg[1] = cve name
# run in build_skeleton(parsed_cvename)

if ARGV.length < 2 # invalid command-line args given
	puts("Invalid args. args[skeleton_file, cve_name[CVE-######]")
	exit
elsif ARGV.length > 2 ## too many args
	puts("Invalid args. args[skeleton_file, cve_name[CVE-######]")
	exit
else
	puts("SUCCESS")
	# run build script here
	puts(ARGV[0] + ARGV[1])
	# args(filename, cve-code
	build_skeleton(ARGV[0], ARGV[1])

end

