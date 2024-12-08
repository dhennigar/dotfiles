#!/bin/bash
## triggers my select-theme.sh script for theme changes.

## $1 = event; $2 = old period; $3 = new period

case $1 in
    period-changed)
	# notify-send -t 10000 "Gammastep" "$1 from $2 to $3"
	case $3 in
	    daytime)
		select-theme.sh day
		;;
	    night)
		select-theme.sh bright
		;;
	    transition)
		if [ $(date +"%H") -lt 12 ]
		then
		    select-theme.sh morning
		else
		    select-theme.sh night
		fi
		;;
	esac
	;;
esac
