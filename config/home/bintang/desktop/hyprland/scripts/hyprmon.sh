#!/usr/bin/env bash

MONITORS=$(hyprctl monitors | awk '/^Monitor/ { print $2 }')
MONITOR=$(echo -e "New\n${MONITORS}" | rofi -dmenu -p "Choose Monitor")
[ -z "$MONITOR" ] && exit 1
[ "$MONITOR" = "New" ] && MONITOR=""

case "$(echo -e "Auto\nUp\nDown\nRight\nLeft\nMirror" | rofi -dmenu -p "Choose Monitor Position")" in
    "Auto")
        POS="auto"
        ;;
    "Up")
        POS="auto-up"
        ;;
    "Down")
        POS="auto-down"
        ;;
    "Right")
        POS="auto-right"
        ;;
    "Left")
        POS="auto-left"
        ;;
    "Mirror")
        MIRROR=$(echo -e "Auto\n$MONITORS" | rofi -dmenu -p "Choose Monitor To Be Mirrored")
        [ -z "$MIRROR" ] && exit 1
        [ "$MIRROR" = "Auto" ] && MIRROR="auto"
        ;;
esac
[ -z "$POS" ] && [ -z "$MIRROR" ] && exit 1

if [ -n "$MIRROR" ]; then
    hyprmon -n "$MONITOR" -m "$MIRROR"
else
    hyprmon -n "$MONITOR" -p "$POS"
fi