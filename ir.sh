#!/bin/sh

cmd="$1"
log=~/some/log.ir.sh
#echo "`date` $cmd" >>$log
export DISPLAY=:0

case "$cmd" in
play)
	if ps -e | grep smplayer
	then
		smplayer -send-action play_or_pause
	else
		qdbus org.kde.amarok /Player PlayPause
	fi
;;
stop)
	if ps -e | grep smplayer
	then
		smplayer -send-action fullscreen
	else
		qdbus org.kde.amarok /Player Stop
	fi
;;
bwd)
	if ps -e | grep smplayer
	then
		smplayer -send-action play_prev
	else
		qdbus org.kde.amarok /Player Prev
#		qdbus org.kde.amarok /Player ShowOSD
	fi
;;
fwd)
	if ps -e | grep smplayer
	then
		smplayer -send-action play_next
	else
		qdbus org.kde.amarok /Player Next
#		qdbus org.kde.amarok /Player ShowOSD
	fi
;;
repeat)
;;

b1)
	if ps -e | grep smplayer
	then
		smplayer -send-action rewind1
	else
		qdbus org.kde.amarok /Player Backward 2
	fi
;;
b2)
	if ps -e | grep smplayer
	then
		smplayer -send-action forward1
	else
		qdbus org.kde.amarok /Player Forward 2
	fi
;;
b3)
	killall mplayer
;;
b4)
	if ps -e | grep smplayer
	then
		smplayer -send-action rewind1
	else
		qdbus org.kde.amarok /Player Backward 20
	fi
;;
b5)
	if ps -e | grep smplayer
	then
		smplayer -send-action forward1
	else
		qdbus org.kde.amarok /Player Forward 20
	fi
;;
b6)
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
	qdbus org.kde.kmix /Mixer0 increaseVolume PCM:0
#	qdbus org.kde.kmix /Mixer1 increaseVolume Master:0
;;
vol-)
	qdbus org.kde.kmix /Mixer0 decreaseVolume PCM:0
#	qdbus org.kde.kmix /Mixer1 decreaseVolume Master:0
;;
esac

