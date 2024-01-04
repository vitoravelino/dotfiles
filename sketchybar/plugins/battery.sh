#!/bin/sh

PERCENTAGE=$(pmset -g batt | grep -Eo "\d+%" | cut -d% -f1)
CHARGING=$(pmset -g batt | grep 'AC Power')

if [ $PERCENTAGE = "" ]; then
  exit 0
fi

case ${PERCENTAGE} in
  100)
    ICON=""
    COLOR=0xff40916c
  ;;
  9[0-9])
    ICON=""
    COLOR=0xff1f2430
  ;;
  [6-8][0-9])
    ICON=""
    COLOR=0xff1f2430
  ;;
  [3-5][0-9])
    ICON=""
    COLOR=0xff1f2430
  ;;
  2[1-9])
    ICON=""
    COLOR=0xff1f2430
  ;;
  [1-2][0-9])
    ICON=""
    COLOR=0xffd23c3d
  ;;
  *)
    ICON=""
    COLOR=0xffd23c3d
esac

if [[ $CHARGING != "" ]]; then
  ICON=""
fi

# The item invoking this script (name $NAME) will get its icon and label
# updated with the current battery status
sketchybar --set $NAME icon="$ICON" label="${PERCENTAGE}%" icon.color=$COLOR
