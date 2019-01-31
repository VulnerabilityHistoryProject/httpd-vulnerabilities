# httpd-vulnerabilities
Data for [vulnerabilityhistory.org](http://vulnerabilityhistory.org/)

# Travis Build [![Build Status](https://travis-ci.org/VulnerabilityHistoryProject/httpd-vulnerabilities.svg?branch=master)](https://travis-ci.org/VulnerabilityHistoryProject/httpd-vulnerabilities)

Every push and pull request is run against our integrity checkers on Travis. Click on the above tag to see the status of the build.
##

# For SWEN 331 Students

Please see the [assignments](assignment/) folder for information about your project.

## Testing project locally

  1. You'll need Ruby 2.4+
  2. Run `gem install bundler` (if you don't already have bundler)
  3. `cd` to the root of this repo, run `bundle install`
  4. Run `bundle exec rake`

  If the output has no *failures*, then it checks out!

 ![Test Successful Screenshot](/screenshots/successful-unit-test.png)

##
### [Contributor Notes](https://github.com/andymeneely/httpd-vulnerabilities/blob/master/CONTRIBUTING.md)

# Generate "Weeklies" Git Log Reports

Make sure you have the Chromium repo cloned in `tmp/src`. From the root of the repo, run:

```
$ scripts/generate_weeklies.rb --skip-existing
```

Or for a clean build, you can delete all weeklies and start over.

For a list of options it supports, run `scripts/generate_weeklies.rb`


# Populate gitlog.json with a single SHA

Be in the root of this repository, and run:

```
ruby scripts/add_commit.rb --sha commit_sha_to_add
```

See the source code for other options.

# Populate gitlog.json with any mentioned SHA in CVE yamls

When you want to make sure that any commit that's mentioned in a YAML is also in the gitlog, you can run this script. It will NOT figure out commits between VCC and Fix, however.

Be in the root of this repository, and run:

```
ruby scripts/add_mentioned_commits.rb
```

This will overwrite any commit and take a LONG time (5-10 minutes). If you just want to go quickly and add what's not already there, use:

```
ruby scripts/add_mentioned_commits.rb --skip-existing
```

So if a commit is already in gitlog.json then we won't look it up in the GitLog. This is a much faster option.

By default, this script checks the `tmp/src` directory. If you need, say, `v8`, there's an option for that.

# Populate gitlog.json with any SHA to a vulnerable file

This script will do a `git log` on every vulnerable file and add it to the git log. Takes much longer than its peers above.

```
ruby scripts/add_vulnerable_file_commits.rb
```

# Download Latest CVEs

Run the HTTPD scraper to get all CVEs, and don't touch the ones that don't exist.

This won't add fixes, just fill in the CVE into the skeleton.

`$ rake pull:cves`
