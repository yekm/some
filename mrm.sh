#!/bin/sh
for r in "*.log" "*.m3u" "Thumb.jpg" "folder.jpg" "Thumbs.db" "Info.txt" ; do
	find . -iname "$r"
	[ -z "$FAKE" ] && find . -iname "$r" -exec rm '{}' +
done
