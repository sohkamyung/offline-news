#! /bin/bash
timeout=60

maxLevel=1
waitTime=2
# for silly sites like Economist.com
# userAgent="Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.12"
userAgent="Mozilla/5.0 (Linux; Android 4.0.4; Galaxy Nexus Build/IMM76B) AppleWebKit/535.19 (KHTML, like Gecko) Chrome/18.0.1025.133 Safari/535.19"

acceptList=

# rejectList="css,js,spacer.gif,black.gif,Spacer.gif,spn-printable-hd.gif"
rejectList="js,spacer.gif,black.gif,Spacer.gif,spn-printable-hd.gif"

excludeDirList="/cache,/blocks,/content"

acceptDomainList="localhost,www.economist.com,media.economist.com,cdn.static-economist.com"

wget --no-check-certificate --restrict-file-names="windows,nocontrol" --timeout=${timeout} --execute robots=off --user-agent="${userAgent}" --html-extension --convert-links --timestamping --recursive --page-requisites --span-hosts --level=${maxLevel} --wait=${waitTime} --random-wait --domains="${acceptDomainList}" --reject "${rejectList}" --exclude-directories=${excludeDirList} "http://localhost/economist-weekly.html"
