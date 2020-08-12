# httpd-vulnerabilities
Data for [vulnerabilityhistory.org](http://vulnerabilityhistory.org/)

# Travis Build [![Build Status](https://travis-ci.org/VulnerabilityHistoryProject/httpd-vulnerabilities.svg?branch=master)](https://travis-ci.org/VulnerabilityHistoryProject/httpd-vulnerabilities)

Every push and pull request is run against our integrity checkers on Travis. Click on the above tag to see the status of the build.

##

# For SWEN 331 Students


Please see your course website for instructions. This README is more for people managing this data.

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

Use the VHP shepherd tools for this.

Make sure you have the HTTPD repo cloned in `tmp/src`. From the root of the repo, run:

```
$ vhp weeklies
```

For a list of all options do `vhp help weeklies`.


# Populate gitlog.json with any mentioned git commits in CVE yamls

Use the VHP shepherd tools for this.

When you want to make sure that any commit that's mentioned in a YAML is also in the gitlog, you can run this script.

_This will NOT figure out commits between VCC and Fix, however.__

Be in the root of this repository, and run:

```
$ vhp loadcommits
```

# Download Latest CVEs

To run this script, you'll need Mechanize installed. We intentionally don't put Mechanize into the `Gemfile` because that could (has) broken or slowed the build. Instead, you'll need to install locally:

```
$ gem install mechanize
```

Then, from the root of the repo, run the HTTPD scraper to get all CVEs, generating skeleton YMLs for ones that already exist. This won't add fixes, just fill in the CVE into the skeleton.

```
$ ruby scripts/pull_latest_cves.rb
```

Be sure to inspect this before you commit them.

# Which CVEs don't have fixes?

Use shepherd tools:

```
$ vhp nofixes
```

# Finding Fixes for HTTPD CVEs

We don't have a very automated process for getting fixes, but fortunately they don't come out with new vulnerabilities so fast that we need automation. Here's some places to look:

* On the CVE database entry, sometimes they mention a commit if you're lucky.
* Sometimes a commit message will mention the CVE. Use `git log --grep="CVE-XXXX-XXXXX"` to find your CVE.
* Often, a commit will be done BEFORE a CVE is registered, in which case you'll want to do `git log --grep` but looking for key words.
* You can also take a look at their [CHANGES](https://github.com/apache/httpd/blob/trunk/CHANGES) file for similar key words. Be sure to look at the "affects" versions on the security page (this is [2.4's for example](https://httpd.apache.org/security/vulnerabilities_24.html)) and make sure the date makes sense.
* In a pinch, you can use GitHub to do a blame on the CHANGES file. HTTPD devs will often edit the CHANGES in the same commit as a vulnerability fix. If not, it's in a nearby commit in time.
* In a real pinch, you can just do `git log` around the dates you've seen and look at all commits - this is tedious and a last resort. **Note** that the CVE year is not a good indicator of when the vulnerability was fixed - sometimes developers will register a CVE years after they fixed it. Use the original dates from the repo.
