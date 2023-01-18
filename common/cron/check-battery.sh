#!/bin/bash

LOW_BATTERY="25"
CRITICAL_BATTERY="15"

BATTERY_PATH="/sys/class/power_supply/BAT1/"

REMAINING_TIME="$(upower -i /org/freedesktop/UPower/devices/battery_BAT1 | grep 'time to empty' | xargs | cut -d':' -f2 | cut -c 2-) to empty"

if [ -e "$BATTERY_PATH" ]; then
    STATUS=$(cat $BATTERY_PATH/status)
    CAPACITY=$(cat $BATTERY_PATH/capacity)

    if [ "$STATUS" == "Discharging" ]; then
      if [ "$CAPACITY" -lt "$CRITICAL_BATTERY" ]; then
          DISPLAY=:0 DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus notify-send "Discharging ($CAPACITY%)" "$REMAINING_TIME"
          timeout -k 0.75s 5s speaker-test --frequency 2000 --test sine >/dev/null

      elif [ "$CAPACITY" -lt "$LOW_BATTERY" ]; then
          DISPLAY=:0 DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus notify-send "Discharging ($CAPACITY%)" "$REMAINING_TIME"
          timeout -k 0.75s 1s speaker-test --frequency 2000 --test sine >/dev/null
      fi
    fi
fi
