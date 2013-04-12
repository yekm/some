#!/bin/bash

[ -z "$1" ] && echo "specify username" && exit -1
ljuser=$1
ljhost="$ljuser.livejournal.com"
years=$(wget -O - "$ljhost/calendar" | perl -ne 'm,'$ljhost'/(\d{4})/, && print "$1\n"' | sort -u)
for year in $years; do
    days=$(wget -O - "$ljhost/$year" | perl -ne 'm,'$ljhost'/(\d{4})/(\d{2})/(\d{2}), && print "$1/$2/$3\n"' | sort -u)
    for day in $days; do
        echo "$ljhost/$day"
    done
done | sort -u | tee $ljuser-posts

