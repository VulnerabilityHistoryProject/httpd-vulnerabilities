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
