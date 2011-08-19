#!/bin/sh

[ -z "$to" ] && to=.

list=$(find -L "$from" -iname "$what" -type f)
count=$(echo "$list" | wc -l)
echo "$list" | while read f ; do
    let "c = c + 1"
    echo -n "$c/$count "
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
    case "$todo" in
    thumb)
        o1="$to/$dn/$fn"
        o2="$to/$dn/small_$fn"
        [ -z $FAKE ] && [ ! -f "$o1" ] && convert "$f" -resize x400 "$o1"
        [ -z $FAKE ] && [ ! -f "$o2" ] && convert "$o1" -resize x20 "$o2"
    ;;
    fat)
        tofn=$(echo -n "$fn" | perl -pe 's/[^a-z0-9A-Z\-\(\) \.]/_/g')
        #todn=$(echo "$dn" | tr -d '\/:*?<>|')
        t="$to/$dn/$tofn"
        if [ -f "$t" ]; then
            if [ $(du "$f" | cut -f1) -gt $(du "$t" | cut -f1) ] ; then
                [ -z $FAKE ] && cp "$f" "$t"
                echo -n "copied"
            else
                echo -n "skipped"
            fi
        else
            [ -z $FAKE ] && cp "$f" "$t"
            echo -n "copied"
        fi
        echo " $f -> $t"
    ;;
    tojpeg)
        jpeg="$to/$dn/${fn%.*}.jpg"
        echo -e "$f \t\t $jpeg"
        gm convert "$f" -quality 90 "$jpeg"
    ;;
    *)
        echo -e "$f \t\t $to/$dn"
        [ -z $FAKE ] && cp -v "$f" "$to/$dn"
    ;;
    esac
done

