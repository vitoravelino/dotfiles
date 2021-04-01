#!/bin/bash

pamixer --toggle-mute

MUTE=$(pamixer --get-mute)

if [ "$MUTE" == 'true' ]; then
  STATE='muted'
else
  STATE="unmuted ($(pamixer --get-volume)%)"
fi

notify-send "Volume: $STATE"
