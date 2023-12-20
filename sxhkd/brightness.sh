#!/bin/sh

if [ "$1" == "up" ]; then
  brightnessctl s 10%+
fi

if [ "$1" == "down" ]; then
  brightnessctl s 10%-
fi

dunstctl close
notify-send "Brightness: $(light | cut -d '.' -f 1)%"
