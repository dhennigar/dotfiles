#!/usr/bin/env bash

PROG=$( basename "$0" )
toggle=""
origin=""
verbose="-q"
msg="i3-msg"
tree_label="instance"
[[ "$SWAYSOCK" ]] && {
    msg="swaymsg"
    tree_label="app_id"
}

TEMP=$( getopt --options sthv --longoptions toggle-scratchpad,send-to-origin,verbose,help -- "$@" ) || exit 1
eval set -- "$TEMP"

for i in "$@"; do
    case "$i" in
        -h|--help)
            echo "Usage: $PROG OPTIONS target [runstring]"
            echo
            echo "Give focus to a program based on target (app_id for sway or class for X). If we can't give focus to something with that app_id or class, then exec 'runstring'" |fmt
            echo
            echo "OPTIONS"
            echo "-t|--toggle-scratchpad    send the program to/from scratchpad"
            echo "-s|--send-to-origin       also send to 0,0"
            echo "-v|--verbose              be verbose"
            exit 0
            ;;
        -t|--tog*)
            toggle="set"
            shift
            ;;
        -s|--send-to-origin)
            origin="set"
            shift
            ;;
        -v|--verbose)
            verbose=""
            ;;
    esac
done

shift
target="$1"
shift
runstring="$*"

if [[ -z "$verbose" ]]; then
    echo "$PROG: target='$target' runstring='$runstring'" >&2
    set -x
fi

[[ "$toggle" ]] && {
    program_data=$( $msg -t get_tree | jq ".. | select(.type?) | select(.app_id==\"$target\" or .window_properties.class==\"$target\")" )
    if [[ "$program_data" ]]; then
        id=$( echo "$program_data" | jq ".id" | head -n 1)
        if [[ "$SWAYSOCK" ]]; then
            visible=$( echo "$program_data" | jq ".visible" | head -n 1)
        else
            if [[ $( echo "$program_data" | jq -r ".focused") == "true" ]]; then
                visible="true"
            else
                visible="false"
            fi
        fi

        if [[ "$visible" == "false" ]]; then
            # shellcheck disable=SC2086
            $msg $verbose "[con_id=$id] move window to workspace current"
            # shellcheck disable=SC2086
            $msg $verbose "[con_id=$id] focus"
            if [[ "$origin" ]]; then
                # shellcheck disable=SC2086
                $msg $verbose "[con_id=$id] move position 0 0"
            fi
        else
            # shellcheck disable=SC2086
            $msg $verbose "[con_id=$id] move window to scratchpad"
        fi
    else
        if [[ "$runstring" ]]; then
            # shellcheck disable=SC2086
            $msg $verbose exec "$runstring"
        fi
    fi
    exit 0
}

# shellcheck disable=SC2086
$msg $verbose "[app_id=\"$target\"] focus" &> /dev/null  || {
    # could be Xwayland app:  
    # shellcheck disable=SC2086
    $msg $verbose "[class=\"$target\"] focus" &> /dev/null || {
        $msg $verbose "[instance=\"$target\"] focus" &> /dev/null  || {
            [[ "$runstring" ]] && {
                # not running yet
                # shellcheck disable=SC2086
                $runstring &
            }
        }
    }
}
