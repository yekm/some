#!/bin/sh

find -L "$from" -iname "$what" -type f | while read f ; do
	base=${f##$from}
	base=${base##/}
	dn=$(dirname "$base")
	[ -n $FAKE ] && echo -e "$f\n$to/$dn\n"
	[ -z $FAKE ] && cp -v "$f" "$to/$dn"
done

