#!/bin/sh

ls $2 | while read l; do
    dst=$(echo "$l" | perl -pe "$1")
    echo "$l -> $dst"
    [ -n "$DOIT" ] && mv -v "$l" "$dst"
done

