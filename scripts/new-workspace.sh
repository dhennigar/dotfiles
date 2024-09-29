#!/usr/bin/env bash
# https://gitlab.com/wef/dotfiles/-/blob/master/bin/i3-next-empty-workspace

# Copyright (C) 2020-2023 Bob Hepple <bob dot hepple at gmail dot com>

# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or (at
# your option) any later version.
# 
# This program is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
# General Public License for more details.
# 
# You should have received a copy of the GNU General Public License
# along with this program. If not, see <http://www.gnu.org/licenses/>.

PROG=$( basename "$0" )
wm="i3"
msg="i3-msg"
[[ "$SWAYSOCK" ]] && {
    wm="sway"
    msg="swaymsg"
}

take=""
forward="set"

while [[ "$1" ]]; do
    case "$1" in
        -h|--help)
            # shellcheck disable=SC2016
            echo "Usage: $PROG [OPTIONS]
Jumps to the next empty workspace. For example, if you're on workspace
1 and there are workspaces [1 2 3 5 6] then you would jump to
workspace 4.

  -r, --reverse               reverse direction
  -t, --take-focused          take currently focused with you"
            exit 0
            ;;
        -r|--reverse)
            forward=""
            shift
            ;;
        -d|--debug)
            debug="1"
            shift
            ;;
        -t|--take-focused)
            take=$( $msg -t get_tree | jq '.. | select(.type?) | select(.focused==true) | .id' )
            shift
            ;;
    esac
done

this_workspace=$( $msg -t get_workspaces |
                  jq -r '.[] | select(.focused==true)|.num' |
                  awk -F':' '{print $1}' )

if [[ "$forward" ]]; then
    next_workspace=$( $msg -t get_workspaces|
                      jq -r '.[].num'|
                      sort -n |
                      awk -v this_workspace="$this_workspace" -v debug="$debug" '
                      BEGIN {lasti=0}
                      {
                          i=$1+0
                          if (debug) print "i=" i >"/dev/stderr"
                          if (i > 0) {
                              if (lasti > 0) {
                                  if (i > lasti+1) {exit}
                              }
                              if (i >= this_workspace) lasti = i
                          }
                          if (debug) print "lasti=" i >"/dev/stderr"
                      }
                      END{if (lasti > 0) { print lasti+1}}'  
                  )
else
    next_workspace=$( $msg -t get_workspaces|
                      jq -r '.[].num'|
                      sort -rn |
                      awk -v this_workspace="$this_workspace" '
                      BEGIN {lasti=0}
                      {
                          i=$1+0
                          if (debug) print "i=" i >"/dev/stderr"
                          if (i > 0) {
                              if (lasti == 0) {
                                  if (i <= this_workspace) lasti = i
                              } else {
                                  if (i > 1) {
                                      if (i < lasti-1) {exit}
                                      if (i <= this_workspace) lasti=i
                                  } else {
                                      lasti=1
                                  }
                              }
                          }
                          if (debug) print "lasti=" i >"/dev/stderr"
                      }
                      END{if (lasti > 1) print lasti-1}'  
                  )
fi

[[ "$next_workspace" ]] && {
    cmd="workspace $next_workspace"
    [[ "$take" ]] && cmd="move --no-auto-back-and-forth window to workspace number $next_workspace; $cmd"
    $msg "$cmd"
}
