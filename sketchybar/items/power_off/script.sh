#!/bin/sh

TOPPROC=$(top -l  2 | head -n 5 | grep -E "^CPU" | tail -1 | awk '{ print $3 + $5"%" }' | cut -d "." -f1)

sketchybar --set $NAME label="$TOPPROC%"

