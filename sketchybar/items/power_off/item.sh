POWER_OFF=(
  icon=
  icon.background.color=0xffDADBC0
  icon.background.height=28
  icon.color=0xff1f2430
  icon.padding_left=7
  icon.padding_right=7
  label.drawing=off
  # click_script="$PLUGIN_DIR/clock.sh"
)

sketchybar --add item poweroff right \
           --set poweroff "${POWER_OFF[@]}"
