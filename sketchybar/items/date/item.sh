DATE=(
  update_freq=10
  script="$CONFIG_DIR/items/date/script.sh"
)

sketchybar --add item date q \
           --set date "${DATE[@]}"
