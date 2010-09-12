#!/bin/sh

cmd="$1"

c=1
amixer -c 0 controls | grep "PCM Playback Volume" && c=0

log=~/some/log.ir.sh
#echo "`date` $cmd" >>$log
export DISPLAY=:0

case "$cmd" in
play)
	if pgrep smplayer
	then
		smplayer -send-action play_or_pause
	else
		#qdbus org.kde.amarok /Player PlayPause
		mocp --toggle-pause
	fi
;;
stop)
	if pgrep smplayer
	then
		smplayer -send-action fullscreen
	else
		#qdbus org.kde.amarok /Player Stop
		mocp --stop
	fi
;;
bwd)
	if pgrep smplayer
	then
		smplayer -send-action play_prev
	else
		#qdbus org.kde.amarok /Player Prev
#		qdbus org.kde.amarok /Player ShowOSD
		mocp --previous
	fi
;;
fwd)
	if pgrep smplayer
	then
		smplayer -send-action play_next
	else
		#qdbus org.kde.amarok /Player Next
#		qdbus org.kde.amarok /Player ShowOSD
		mocp --next
	fi
;;
repeat)
;;

b1)
	if pgrep smplayer
	then
		smplayer -send-action rewind1
	else
		#qdbus org.kde.amarok /Player Backward 2
		mocp --seek -2
	fi
;;
b2)
	if pgrep smplayer
	then
		smplayer -send-action forward1
	else
		#qdbus org.kde.amarok /Player Forward 2
		mocp --seek 2
	fi
;;
b3)
;;
b4)
	if pgrep smplayer
	then
		smplayer -send-action rewind1
	else
		#qdbus org.kde.amarok /Player Backward 20
		mocp --seek -20
	fi
;;
b5)
	if pgrep smplayer
	then
		smplayer -send-action forward1
	else
		#qdbus org.kde.amarok /Player Forward 20
		mocp --seek 20
	fi
;;
b6)
	killall mplayer
;;
b7)
	smplayer -send-action dec_zoom
;;
b8)
	smplayer -send-action inc_zoom
;;
b9)
	smplayer -send-action reset_zoom
;;
b10)
	smplayer -send-action dec_sub_scale
;;
b+10)
	smplayer -send-action inc_sub_scale
;;

vol+)
	amixer -c $c set PCM 2dB+
;;
vol-)
	amixer -c $c set PCM 2dB-
;;
esac

