#!/bin/sh

source $CONFIG_DIR/colors.sh

CPU=(
  mach_helper="$HELPER"
  update_freq=4
  label=0%
  label.color=$WIDGET_LABEL_COLOR
  label.background.color=$WIDGET_LABEL_BG_COLOR
  label.background.height=28
  label.padding_left=7
  label.padding_right=7
  icon=
  icon.background.color=$WIDGET_ICON_BG_COLOR
  icon.background.height=28
  icon.color=$WIDGET_ICON_COLOR
  icon.padding_left=7
  icon.padding_right=7
)

sketchybar --add item cpu.percent right \
           --set cpu.percent "${CPU[@]}"
