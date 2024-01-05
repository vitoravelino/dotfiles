CLOCK=(
  update_freq=10
  icon.drawing=off
  script="$CONFIG_DIR/items/clock/script.sh"
)

sketchybar --add item clock e \
           --set clock "${CLOCK[@]}"
