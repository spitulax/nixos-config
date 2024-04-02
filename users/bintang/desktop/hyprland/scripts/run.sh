#!/usr/bin/env bash

case "$1" in
  "rofi")
    rofi -combi-modes window,drun -font "monospace 10" -icon-theme "Papirus-Dark" -show combi -show-icons -terminal $TERMINAL &
    ;;
  "file-manager")
    $FILE_MANAGER &
    ;;
  "browser")
    $BROWSER &
    ;;
  "terminal")
    $TERMINAL &
    ;;
  "btop")
    $TERMINAL btop &
    ;;
  "colorpicker")
    COLOR=$(hyprpicker -a -f hex)
    notify-send -a popup -t 5000 "Color copied" "󰏘  $COLOR" &
    ;;
esac
