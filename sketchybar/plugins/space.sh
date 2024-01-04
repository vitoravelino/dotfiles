#!/bin/sh

# The $SELECTED variable is available for space components and indicates if
# the space invoking this script (with name: $NAME) is currently selected:
# https://felixkratz.github.io/SketchyBar/config/components#space----associate-mission-control-spaces-with-an-item

if [ $SELECTED = 'true' ]
then
  sketchybar --set $NAME label.drawing=$SELECTED \
                         label.color=0xffDADBC0 \
                         label.background.color=0xff3d4150 \
                         label.background.height=28 \
                         label.padding_left=7 \
                         label.padding_right=7 \
                         icon.background.color=0xffDADBC0 \
                         icon.background.height=28 \
                         icon.color=0xff1f2430 \
                         icon.padding_left=7 \
                         icon.padding_right=7
else
  color=$(yabai -m query --spaces --space $SID | jq -r 'if .windows == [] then "0xff3d4150" else "0xffDADBC0" end')

  sketchybar --set $NAME label.drawing=$SELECTED \
                         icon.padding_left=4                       \
                         icon.padding_right=4                      \
                         icon.color=${color:=0xff3d4150} \
                         icon.background.drawing=off
fi
