CPU=(
  mach_helper="$HELPER"
  update_freq=4
  label=0%
  label.color=0xffDADBC0
  label.background.color=0xff3d4150
  label.background.height=28
  label.padding_left=7
  label.padding_right=7
  icon=
  icon.background.color=0xffDADBC0
  icon.background.height=28
  icon.color=0xff1f2430
  icon.padding_left=7
  icon.padding_right=7
)

sketchybar --add item cpu.percent right \
           --set cpu.percent "${CPU[@]}"
