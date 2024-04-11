#!/usr/bin/env bash

case "$1" in
  "runner")
    rofi -show drun &
    ;;
  "clipboard")
    cliphist list | rofi -dmenu | cliphist decode | wl-copy &
    ;;
  "emoji")
    rofi -modi emoji -show emoji &
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
  "nvtop")
    $TERMINAL nvtop &
    ;;
  "auto-cpufreq")
    auto-cpufreq-gtk &
    ;;
  "colorpicker")
    COLOR=$(hyprpicker -a -f hex)
    [[ -n "$COLOR" ]] && notify-send -a popup -t 5000 "Color copied" "󰏘  $COLOR" &
    ;;
esac
