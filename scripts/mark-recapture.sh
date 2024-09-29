#!/bin/bash

# mark-recapture.sh

command=$( basename "$0" )
new=""
msg="i3-msg"
tree_label="instance"
[[ "$SWAYSOCK" ]] && {
    msg="swaymsg"
    tree_label="app_id"
}

TEMP=$( getopt --options nsh --longoptions new,summon,help -- "$@" ) || exit 1
eval set -- "$TEMP"

for i in "$@"; do
    case "$i" in
	-h|--help)
	    echo "Usage: $command OPTIONS"
	    echo
	    echo "Mark the focused window for easy recall"
	    echo
	    echo "OPTIONS"
	    echo "-n|--new      mark a new window, replacing the old one"
	    echo "-s|--summon   summon the marked window to the current workspace"
	    exit 0
	    ;;
	-n|--new)
	    new="set"
	    shift
	    ;;
	-s|--summon)
	    summon="set"
	    shift
	    ;;	
    esac
done

marked=$( $msg -t get_tree | jq ".. | select(.type?) | select(.marks[0]==\"mark\")" )

if [[ "$marked" ]]; then
    if [[ "$new" ]]; then
	$msg "[con_id=__focused__] mark --add \"mark\""
    else
	if [[ "$summon" ]]; then
	    $msg "[con_mark=mark] move to workspace current"
	fi
	$msg "[con_mark=mark] focus"
    fi
else
    $msg "[con_id=__focused__] mark --add \"mark\""
fi
