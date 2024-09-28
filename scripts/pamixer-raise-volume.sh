#!/bin/bash
# Raise the volume with pamixer and update wob indicator if it exists.

pamixer -u # unmute
pamixer -i 5 # increase volume
VOL=$(pamixer --get-volume) # get current volume
echo $VOL volume > /tmp/wobpipe # update volume indicator

