#!/bin/bash

echo Pulling "$1"
PUBDATE=`curl -s https://nvd.nist.gov/vuln/detail/$1 | grep 'vuln-published-on' | grep -o "[0-9]*/[0-9]*/[0-9]*"`

echo "Replacing ..."

sed "s@announced_date:@announced: $PUBDATE@g" cves/$1.yml > tmp.txt

mv tmp.txt cves/$1.yml
