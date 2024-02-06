#!/bin/sh

source $CONFIG_DIR/colors.sh

POWER_OFF=(
  icon=
  icon.background.color=$WIDGET_ICON_BG_COLOR
  icon.background.height=28
  icon.color=$WIDGET_ICON_COLOR
  icon.padding_left=7
  icon.padding_right=7
  label.drawing=off
  # click_script="$PLUGIN_DIR/clock.sh"
)

sketchybar --add item poweroff right \
           --set poweroff "${POWER_OFF[@]}"
