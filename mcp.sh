#!/bin/sh

find -L "$from" -iname "$what" -type f | while read f ; do
	fn=$(basename "$f")
	base=${f##$from}
	base=${base##/}
	dn=$(dirname "$base")
	if [ ! -d "$to/$dn" ] ; then
		# if destination folder do not exist...
		[ -z $create ] && continue # ...skip
		# ...or create and proceed
		mkdir -p "$to/$dn"
	fi
	[ -n $FAKE ] && echo -e "$f ---> $to/$dn/$fn"
	case "$TODO" in
	thumb)
		o1="$to/$dn/$fn"
		o2="$to/$dn/small_$fn"
		[ -z $FAKE ] && [ ! -f "$o1" ] && convert "$f" -resize x400 "$o1"
		[ -z $FAKE ] && [ ! -f "$o2" ] && convert "$o1" -resize x20 "$o2"
	;;
	*)
		[ -z $FAKE ] && cp -v "$f" "$to/$dn"
	;;
	esac
done

