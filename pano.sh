#!/bin/sh

ls -1 $@ | while read f ; do
	j="${f%%.*}"
	echo "$0: $f ($j)"
	convert "$f" -quality 95 "$j.jpg"
	[ -n "$P" ] && cp -v "$j.jpg" "/mnt/shome/ftp/p/pano/$P"
	f="$j.jpg"
	echo "$0: $f"
	[ ! -f "$f.tif" ] && \
		vips im_vips2tiff "$f" "$f.tif":jpeg:95,tile:256x256,pyramid
	[ -n "$P" ] && mv -v "$f.tif" "/mnt/shome/ftp/p/pyramid/$P"
	create=1 TODO=thumb from="/mnt/shome/ftp/p/pano" to="/mnt/shome/ftp/p/thumb" what="*.jpg" mcp.sh
done

