#!/bin/bash

sleep 2
#/usr/bin/alsa_out -d hw:XDA2,0 -r48000 -j XDA2 &

/usr/bin/alsa_out -d hw:PCH,0 -c 4 -r48000 -j onboard_p &

/usr/bin/alsa_in -d hw:PCH,0 -r48000 -j onboard_c

