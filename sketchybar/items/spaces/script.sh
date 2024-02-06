#!/bin/sh

source $CONFIG_DIR/colors.sh

if [ $SELECTED = 'true' ]
then
  selected_space=(
    label.drawing=$SELECTED
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
  )

  sketchybar --set $NAME "${selected_space[@]}"
else
  color=$(yabai -m query --spaces --space $SID | jq -r 'if .windows == [] then "0xff3d4150" else "0xffDADBC0" end')

  unselected_space=(
    label.drawing=$SELECTED
    icon.padding_left=4
    icon.padding_right=4
    icon.color=${color:=$EMPTY_SPACE_ICON_COLOR}
    icon.background.drawing=off
  )

  sketchybar --set $NAME "${unselected_space[@]}"
fi
