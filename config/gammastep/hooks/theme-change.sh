#!/bin/bash
## triggers my i3-select-theme script for theme changes.

## $1 = event; $2 = old period; $3 = new period

case $1 in
    period-changed)
	# notify-send -t 10000 "Gammastep" "$1 from $2 to $3"
	case $3 in
	    daytime)
		i3-select-theme day
		;;
	    night)
		i3-select-theme bright
		;;
	    transition)
		if [ $(date +"%H") -lt 12 ]
		then
		    i3-select-theme morning
		else
		    i3-select-theme night
		fi
		;;
	esac
	;;
esac
