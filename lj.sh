#!/bin/bash

[ -z "$1" ] && echo "specify username" && exit -1
ljuser=$1
ljhost="$ljuser.livejournal.com"
years=$(wget -O - "$ljhost/calendar" | perl -ne 'm,'$ljhost'/(\d{4})/, && print "'$ljhost/'$1\n"' | sort -u)
days=$(wget -O - $years | perl -ne 'm,'$ljhost'/(\d{4})/(\d{2})/(\d{2}), && print "'$ljhost/'$1/$2/$3\n"' | sort -u)
wget -O - $days | perl -ne 'm,'$ljhost'/(\d+).html, && print "'$ljhost'/$1.html\n"' | sort -u | tee $ljuser-posts
