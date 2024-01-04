#!/bin/bash

LOW_BATTERY="21"

CAPACITY=$(pmset -g batt | grep -Eo "\d+%" | cut -d% -f1)

CHARGING=$(pmset -g batt | grep 'AC Power')

if [ "$CAPACITY" -lt "$LOW_BATTERY" ] && [ "$CHARGING" == "" ]; then
  REMAINING_TIME=$(pmset -g batt | /opt/homebrew/bin/ggrep -Po '(?<=(discharging; )).*(?= present)')

  osascript -e 'display notification "'"$REMAINING_TIME"'" with title "Dischaging ('"$CAPACITY"'%)"'

  say "Connect charger"
fi

