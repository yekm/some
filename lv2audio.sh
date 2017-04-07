#!/bin/bash

if [ -n "$DISPLAY" ]; then
    mpc stop
    killall jalv
    chrt --rr 99 jalv.gtk --jack-name eq12 -l ~/src/repos/lv2/preset/12band http://calf.sourceforge.net/plugins/Equalizer12Band &
    chrt --rr 99 jalv.gtk --jack-name analyzer -l ~/src/repos/lv2/preset/analyzer http://calf.sourceforge.net/plugins/Analyzer &
else
    chrt --rr 99 jalv -q -n eq12 -l ~/src/repos/lv2/preset/12band http://calf.sourceforge.net/plugins/Equalizer12Band >/dev/null &
fi

sleep 5

jack_connect eq12:out_l system:playback_1
jack_connect eq12:out_r system:playback_2

wait
