#!/bin/sh

source $CONFIG_DIR/colors.sh

VOLUME=(
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
  script="$CONFIG_DIR/items/volume/script.sh"
)

sketchybar --add item volume right \
           --set volume "${VOLUME[@]}" \
           --subscribe volume volume_change
