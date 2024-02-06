#!/bin/sh

source $CONFIG_DIR/colors.sh

WEATHER=(
  update_freq=180
  icon=
  label=Loading
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
  script="$CONFIG_DIR/items/weather/script.sh"
)

sketchybar --add item weather right \
           --set weather "${WEATHER[@]}"
