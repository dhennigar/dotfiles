#!/bin/bash
#
# Qtile autostart (Wayland version)

swaybg -i ~/pictures/Wallpapers/rhodo.jpg &
batsignal -b -e -w 20 -c 10 -d 5 &
kanshi &
sleep 5
kanshictl reload &
fnott &
