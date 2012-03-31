#!/bin/sh

cmd="$1"

c=2
#amixer -c 2 controls | grep "PCM Playback Volume" && c=0

log=/home/yekm/log.ir.sh
#echo "`date` $cmd" >>$log
export DISPLAY=:0
mpc='mpc -h yekm_mpd@localhost -p 16600'

case "$cmd" in
play)
	if pgrep mplayer
	then
		mplayer -send-action play_or_pause
	else
		$mpc toggle
	fi
;;
stop)
	if pgrep mplayer
	then
		mplayer -send-action fullscreen
	else
		$mpc --stop
	fi
;;
bwd)
	if pgrep mplayer
	then
		mplayer -send-action play_prev
	else
		$mpc prev
	fi
;;
fwd)
	if pgrep mplayer
	then
		mplayer -send-action play_next
	else
		$mpc next
	fi
;;
repeat)
;;

b1)
	if pgrep mplayer
	then
		mplayer -send-action rewind1
	else
		$mpc seek -00:00:02
	fi
;;
b2)
	if pgrep mplayer
	then
		mplayer -send-action forward1
	else
		#qdbus org.kde.amarok /Player Forward 2
		$mpc seek +00:00:02
	fi
;;
b3)
;;
b4)
	if pgrep mplayer
	then
		mplayer -send-action rewind1
	else
		$mpc seek -00:00:20
	fi
;;
b5)
	if pgrep mplayer
	then
		mplayer -send-action forward1
	else
		$mpc seek +00:00:20
	fi
;;
b6)
	killall mplayer
;;
b7)
	mplayer -send-action dec_zoom
;;
b8)
	mplayer -send-action inc_zoom
;;
b9)
	mplayer -send-action reset_zoom
;;
b10)
	mplayer -send-action dec_sub_scale
;;
b+10)
	mplayer -send-action inc_sub_scale
;;

vol+)
	amixer -c $c set Master 1dB+
;;
vol-)
	amixer -c $c set Master 1dB-
;;
esac

