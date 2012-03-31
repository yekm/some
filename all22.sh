#!/bin/sh
ext="$1"
tasks=$(grep MHz /proc/cpuinfo| wc -l)
#tasks=$(( $tasks + 1 ))
echo "tasks $tasks"
format=ogg7
[ -z "$ext" ] && echo "Usage: $0 <extention> [format=ogg7]" && exit 1
#[ -n "$2" ] && dir="$2/"
[ -n "$2" ] && format="$2"
[ -z "$DIR" ] && DIR="."

p_dir="/tmp/mplayer_pipes"
p0="/tmp/mplayer_pipes/fifo.$$"
mkdir $p_dir 2>/dev/null

i=0

find -L "$DIR" -name "*.$ext" -type f | while read input_file ; do
#	base=$(basename "$input_file")
	base=${input_file##$DIR}
	base=${base##/}
	dn=$(dirname "$base")
	mkdir -p "$dn"
	case "$format" in
	ogg5|ogg7|ogg_voice)
		output_file="${base%%.$ext}".ogg
		coder="oggenc"
	;;
	ogg_6c)
		output_file="${base%%.$ext}".ogg
		coder="oggenc"
		MOPTS="$MOPTS -channels 6"
	;;
	mp3*)
		output_file="${base%%.$ext}".mp3
		coder="lame"
	;;
	flac*)
		output_file="${base%%.$ext}".flac
		coder="flac"
	;;
	wav*)
		output_file="${base%%.$ext}".wav
		coder="flac"
	;;
	speex)
		output_file="${base%%.$ext}".spx
		coder="speex"
		MOPTS="$MOPTS -af pan=1:0.5:0.5,resample=32000:0:2"
	;;
	*)
	;;
	esac

	echo -n ":::::::::::: processing $input_file => $output_file"
	[ -f "$output_file" -a -z "$OVERWRITE" ] && echo -e -n "\033[0;34m file exists. will be skipped. \033[0m"
	[ -f "$output_file" -a -n "$OVERWRITE" ] && echo -e -n "\033[0;31m file exists. will be overwritten. \033[0m"
	echo
	[ -n "$FAKE" ] && continue
	[ -f "$output_file" -a -z "$OVERWRITE" ] && continue

	p=$p0-$i
	mkfifo $p 2>/dev/null
	case "$ext" in
	flac)
        flac -f -d "$input_file" -o "$p" &
	;;
	*)
        mplayer -really-quiet -vc null -vo null -ao pcm:waveheader:fast:file="$p" $MOPTS "$input_file" &
    ;;
    esac

	case "$format" in
	ogg7)
		oggenc -Q -q 7 --advanced-encode-option impulse_noisetune=-7 "$p" -o "$output_file" &
	;;
	ogg5)
		oggenc -Q -q 5 --advanced-encode-option impulse_noisetune=-7 "$p" -o "$output_file" &
	;;
	ogg_6c)
		oggenc -r -C 6 -R 48000 -q 7 --advanced-encode-option impulse_noisetune=-7 "$p" -o "$output_file" &
	;;
	ogg_voice)
		oggenc -Q -b 64 "$p" -o "$output_file" &
	;;
	mp3v1)
		lame -V1 -m d "$p" "$output_file" &
	;;
	mp3v2)
		lame -V2 -m d "$p" "$output_file" &
	;;
	mp3v3)
		lame -V3 -m d "$p" "$output_file" &
	;;
	mp3v4)
		lame -V4 -m d "$p" "$output_file" &
	;;
	mp3_b)
		lame -b 8 -B 32 -V6 -m m "$p" "$output_file" &
	;;
	flac)
		flac "$p" -o "$output_file" &
	;;
	wav)
		cat "$p" > "$output_file" &
	;;
	speex)
		speexenc -u --vbr --comp 10 "$p" "$output_file" &
	;;
	esac
	[ -n "$REMOVE" ] && rm -v "$input_file"
	i=$(( i + 1 ))
#	[ $(( $i % $tasks )) -eq 0 ] && wait
	while [ $(( $(jobs | wc -l) / 2 )) -gt $tasks  ] ; do
		sleep 1
	done
	wait

done

wait
rm "$p0"*

echo

