#!/bin/sh

find -L "$from" -iname "$what" -type f | while read f ; do
	fn=$(basename "$f")
	base=${f##$from}
	base=${base##/}
	dn=$(dirname "$base")
	if [ ! -d "$to/$dn" ] ; then
		# if destination folder do not exist...
		[ -z $create ] && break # ...skip
		# ...or create and proceed
		mkdir "$to/$dn"
	fi
	[ -n $FAKE ] && echo -e "$f ---> $to/$dn/$fn"
	case "$TODO" in
	thumb)
		[ -z $FAKE ] && [ ! -f "$to/$dn/$fn" ] && convert "$f" -resize x400 "$to/$dn/$fn"
		fn="small_$fn"
		[ -z $FAKE ] && [ ! -f "$to/$dn/$fn" ] && convert "$f" -resize x20 "$to/$dn/$fn"
	;;
	*)
		[ -z $FAKE ] && cp -v "$f" "$to/$dn"
	;;
	esac
done

