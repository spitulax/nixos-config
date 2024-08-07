#!/usr/bin/env bash

case "$1" in
  "runner")
    rofi -show drun &
    ;;
  "windows")
    rofi -show window &
    ;;
  "command")
    rofi -show run &
    ;;
  "clipboard")
    # cliphist list | rofi -dmenu | cliphist decode | wl-copy &
    rofi -modi "clipboard:$XDG_CONFIG_HOME/rofi/modes/clipboard.sh" -show clipboard &
    ;;
  "emoji")
    rofi -modi emoji -show emoji &
    ;;
  "gui-file-manager")
    $GUI_FILE_MANAGER &
    ;;
  "tui-file-manager")
    $TERMINAL $TUI_FILE_MANAGER &
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
