#!/bin/sh

source $CONFIG_DIR/colors.sh

BATTERY=(
  update_freq=120
  label.color=$WIDGET_LABEL_COLOR
  label.background.color=$WIDGET_LABEL_BG_COLOR
  label.background.height=28
  label.padding_left=7
  label.padding_right=7
  icon.background.color=$WIDGET_ICON_BG_COLOR
  icon.background.height=28
  icon.color=$WIDGET_ICON_COLOR
  icon.padding_left=7
  icon.padding_right=7
  script="$CONFIG_DIR/items/battery/script.sh"
)

sketchybar --add item battery right \
           --set battery "${BATTERY[@]}" \
           --subscribe battery system_woke power_source_change