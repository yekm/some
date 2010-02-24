#!/bin/sh
#while read l; do echo $l | grep -i "$1" >/dev/null && echo -e "\033[0;31m$l\033[0m" || echo "$l"; done
awk -F "\n" --assign q=$1 '{ if (tolower($1) ~ q) print "\033[0;31m" $1 "\033[0m"; else print $1}'

