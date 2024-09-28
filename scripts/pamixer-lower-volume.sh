#!/bin/bash
# Lower the volume with pamixer and update wob indicator if it exists.

pamixer -u # unmute
pamixer -d 5 # decrease volume
VOL=$(pamixer --get-volume) # get current volume
echo $VOL volume > /tmp/wobpipe # update volume indicator

