#!/bin/sh

STATUS=$(cat /sys/class/power_supply/BAT0/status)
CAPACITY=$(cat /sys/class/power_supply/BAT0/capacity)

if [ $STATUS == "Charging" ]; then
  REMAINING_TIME="$(upower -i /org/freedesktop/UPower/devices/battery_BAT0 | grep 'time to full' | xargs | cut -d':' -f2 | cut -c 2-) to full"
fi

if [ $STATUS == "Discharging" ]; then
  REMAINING_TIME="$(upower -i /org/freedesktop/UPower/devices/battery_BAT0 | grep 'time to empty' | xargs | cut -d':' -f2 | cut -c 2-) to empty"
fi

dunstctl close last
notify-send "$STATUS ($CAPACITY%)" "$REMAINING_TIME"
