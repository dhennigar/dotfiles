#!/bin/bash

# cycle-focus.sh

PROG=$( basename "$0" )
wm="i3"
msg="i3-msg"
[[ "$SWAYSOCK" ]] && {
    wm="sway"
    msg="swaymsg"
}

# TODO: Implement a reverse cycle. Would require proper indexing, I think
reverse=""

TEMP=$( getopt --options rh --longoptions reverse,help -- "$@" ) || exit 1
eval set -- "$TEMP"

for i in "$@"; do
    case "$i" in
        -h|--help)
            echo "Usage: $PROG OPTIONS target [runstring]"
            echo
            echo "Cycle focus through the windows on the current workspace."
            echo
            echo "OPTIONS"
            echo "-r|--reverse             cycle in reverse (NOT YET IMPLEMENTED)"
            exit 0
            ;;
        -r|--reverse)
            reverse="set"
            ;;
    esac
done

# Get the current workspace
workspace=$( $msg -t get_workspaces |
                  jq -r '.[] | select(.focused==true) | .name' |
                  awk -F':' '{print $1}' )

# Get the currently focused window
focused=$( $msg -t get_tree | jq '.. | select(.type?) | select(.focused==true) | .id' )

# Get the list of window ids on the current workspace
window_ids=$( $msg -t get_tree |
		  jq -r --arg ws $workspace '.. | select(.type?=="workspace" and .name==$ws) | recurse(.nodes[]) | select(.name != null and .type?=="con") | .id' ) 

# If windows exist, find the focused one in the list, then focus the next one
if [ -n "$window_ids" ]; then

    found_focused=false
    for window in $window_ids; do
	if $found_focused; then
	    swaymsg "[con_id=$window] focus"
	    exit 0
	fi
	if [ "$window" = "$focused" ]; then
	    found_focused=true
	fi
    done

    # If we reach the end of the list, focus the first window
    first_window=$(echo "$window_ids" | head -n 1)
    swaymsg "[con_id=$first_window]" focus	

fi
