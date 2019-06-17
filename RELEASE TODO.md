Copy and paste this into a GitHub issue:

 - [ ] Pull request queue is reasonably small
 - [ ] Generate weeklies: `git pull` on src
 - [ ] Generate weeklies: `git gc --aggressive` on src
 - [ ] Generate weeklies: e.g. `ruby scripts/generate_weeklies.rb --repo /dev/shm/httpd-src`
 - [ ] Add mentioned: `ruby scripts/add_mentioned_commits.rb --repo /dev/shm/httpd-src`
 - [ ] Add vulnerable: `ruby scripts/add_vulnerable_commits.rb --repo /dev/shm/httpd-src`
