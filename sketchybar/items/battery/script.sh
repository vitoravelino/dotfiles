#!/bin/sh

source $CONFIG_DIR/colors.sh

PERCENTAGE=$(pmset -g batt | grep -Eo "\d+%" | cut -d% -f1)
CHARGING=$(pmset -g batt | grep 'AC Power')

if [ $PERCENTAGE = "" ]; then
  exit 0
fi

case ${PERCENTAGE} in
  100)
    ICON=""
    COLOR=$CHARGED_BATTERY_COLOR
  ;;
  9[0-9])
    ICON=""
    COLOR=$WIDGET_ICON_COLOR
  ;;
  [6-8][0-9])
    ICON=""
    COLOR=$WIDGET_ICON_COLOR
  ;;
  [3-5][0-9])
    ICON=""
    COLOR=$WIDGET_ICON_COLOR
  ;;
  2[1-9])
    ICON=""
    COLOR=$WIDGET_ICON_COLOR
  ;;
  [1-2][0-9])
    ICON=""
    COLOR=$LOW_BATTERY_COLOR
  ;;
  *)
    ICON=""
    COLOR=$LOW_BATTERY_COLOR
esac

if [[ $CHARGING != "" ]]; then
  ICON=""
fi

# The item invoking this script (name $NAME) will get its icon and label
# updated with the current battery status
sketchybar --set $NAME icon="$ICON" label="${PERCENTAGE}%" icon.color=$COLOR
