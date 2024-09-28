#!/bin/bash
# Mute the volume and update the indicator bar

pamixer -t  # toggle the mute status
VOL=$(pamixer --get-volume) # get current volume
VOL_HUMAN=$(pamixer --get-volume-human) # get current volume (human string)
if [[ "$VOL_HUMAN" == "muted" ]]; then
	# if muted, send 0 to the volume indicator
	echo 0 volume > /tmp/wobpipe
else
	# if not muted, send the current volume to the indicator
	echo $VOL volume > /tmp/wobpipe
fi
