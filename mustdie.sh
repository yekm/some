#!/bin/sh
find . -iname "*.cpp" -o -iname "*.h" -type f | while read f; do
	echo $f
	cat "$f" | tr -d "\r" >"${f}_tr-d"
	mv -v "${f}_tr-d" "$f"
done
