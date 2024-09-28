#!/bin/bash
# Increase the brightness and update indicator

brightnessctl --quiet set +5%

BRIGHTNESS=$(brightnessctl -m get)

PERCENT=$(($BRIGHTNESS / 193))

echo $PERCENT brightness > /tmp/wobpipe
