# Catspam
The site that I made just for fun.

## Description
Every weekday, all subscribers receive an email with a picture of a cat
and the ability to rate it from 1 to 7 stars. At the end of each week,
a "weekly report" is created in which all users can see who has voted how.

## Launch
The server must be started at the beginning of a week.

```bash
$ export RAILS_HOST='catspam.com'   # ip or domain name of a current server
$ export GMAIL_USERNAME='catspam42' # emails will be sent from this address
$ export GMAIL_PASSWORD='123..'     # your gmail account password
$ export DISABLED='false'           # disable sending emails and show "disable banner"

$ bin/rails db:setup
$ bin/rails server
```
