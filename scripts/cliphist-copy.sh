#!/bin/sh

cliphist list | fuzzel -d | cliphist decode | wl-copy
