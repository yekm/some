#!/bin/sh

find -L "$from" -iname "$what" -type f | while read f ; do
	base=${f##$from}
	base=${base##/}
	dn=$(dirname "$base")
	if [ ! -d "$to/$dn" ] ; then
		# if destination folder do not exist...
		[ -z $create ] && break # ...skip
		# ...or create and proceed
		mkdir "$to/$dn"
	fi
	[ -n $FAKE ] && echo -e "$f\n$to/$dn\n"
	[ -z $FAKE ] && cp -v "$f" "$to/$dn"
done

