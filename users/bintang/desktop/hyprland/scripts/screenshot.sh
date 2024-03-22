#!/usr/bin/env bash

NAME="$XDG_SCREENSHOT_DIR/Screenshot_$(date '+%Y%m%d_%H%M%S').png"
LAST_REGION_FILE="$XDG_CACHE_HOME/slurp-last"

if [[ ! -w $LAST_REGION_FILE ]]; then
  touch $LAST_REGION_FILE
fi

case "$1" in
  full)
    grim - | wl-copy
    wl-paste > "$NAME"
    ;;
  region)
    REGION=$(hyprctl clients -j | \
      jq -r --argjson workspaces "$(hyprctl monitors -j | jq -r 'map(.activeWorkspace.id)')" \
      'map(select([.workspace.id] | inside($workspaces)))' | \
      jq -r '.[] | "\(.at[0]),\(.at[1]) \(.size[0])x\(.size[1])"' | \
      slurp "$@")
    grim -g "$REGION" - | wl-copy
    wl-paste > "$NAME"
    echo "$REGION" > "$LAST_REGION_FILE"
    ;;
  last-region)
    if [[ -r $LAST_REGION_FILE ]]; then
      grim -g "$(cat $LAST_REGION_FILE)" - | wl-copy
      wl-paste > "$NAME"
    else
      exit 1
    fi
    ;;
  active-window)
    REGION=$(hyprctl activewindow -j | jq -r '"\(.at[0]),\(.at[1]) \(.size[0])x\(.size[1])"')
    grim -g "$REGION" - | wl-copy
    wl-paste > "$NAME"
    echo "$REGION" > "$LAST_REGION_FILE"
    ;;
  *)
    echo "full, region, last-region, active-window"
    exit 1
esac

notify-send -a grim "Screenshot taken ($1)" "Saved to $NAME" &
