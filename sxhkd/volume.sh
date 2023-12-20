#!/bin/sh

pamixer --unmute

if [ "$1" == "up" ]; then
  pamixer -i 10
fi

if [ "$1" == "down" ]; then
  pamixer -d 10
fi

dunstctl close
notify-send "Volume: $(pamixer --get-volume)%"
