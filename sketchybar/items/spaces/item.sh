#!/bin/sh

source $CONFIG_DIR/colors.sh

SPACE_ICONS=("" "" "" "" "" "" "" "" "")
SPACE_LABELS=("home" "web" "terminal" "code" "chat" "music" "video" "files" "misc")

for i in "${!SPACE_ICONS[@]}"
do
  sid=$(($i+1))

  space=(
    space=$sid
    icon=${SPACE_ICONS[i]}
    icon.color=$EMPTY_SPACE_ICON_COLOR
    label=${SPACE_LABELS[i]}
    label.drawing=off
    script="$CONFIG_DIR/items/spaces/script.sh"              \
    click_script="yabai -m space --focus $sid"
  )

  sketchybar --add space space.$sid left \
             --set space.$sid "${space[@]}"
done
