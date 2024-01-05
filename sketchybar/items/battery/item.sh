BATTERY=(
  update_freq=120
  label.color=0xffDADBC0
  label.background.color=0xff3d4150
  label.background.height=28
  label.padding_left=7
  label.padding_right=7
  icon.background.color=0xffDADBC0
  icon.background.height=28
  icon.color=0xff1f2430
  icon.padding_left=7
  icon.padding_right=7
  script="$CONFIG_DIR/items/battery/script.sh"
)

sketchybar --add item battery right \
           --set battery "${BATTERY[@]}" \
           --subscribe battery system_woke power_source_change
