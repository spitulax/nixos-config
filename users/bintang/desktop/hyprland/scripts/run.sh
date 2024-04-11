#!/usr/bin/env bash

case "$1" in
  "runner")
    rofi -combi-modes window,drun -font "monospace 10" -icon-theme "Papirus-Dark" -show combi -show-icons -terminal $TERMINAL &
    ;;
  "clipboard")
    cliphist list | rofi -dmenu | cliphist decode | wl-copy &
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
