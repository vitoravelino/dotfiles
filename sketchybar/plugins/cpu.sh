#!/bin/sh

# The $NAME variable is passed from sketchybar and holds the name of
# the item invoking this script:
# https://felixkratz.github.io/SketchyBar/config/events#events-and-scripting

TOPPROC=$(top -l  2 | head -n 5 | grep -E "^CPU" | tail -1 | awk '{ print $3 + $5"%" }' | cut -d "." -f1)

sketchybar --set $NAME label="$TOPPROC%"

