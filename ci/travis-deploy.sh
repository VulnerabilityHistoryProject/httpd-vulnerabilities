#Launching the Travis CI Script

echo "Travis Testing Script"

# Script should exit when something fails, but also print out all commands ran
set -ev

#runs cve unit test check
ruby cve_unit_test.rb
