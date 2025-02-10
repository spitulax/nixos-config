#!/usr/bin/env bash

run () {
    uwsm app -- $@ &
}

EXTRA_ARGS=${@:2:${#@}}

case "$1" in
    "runner")
        run rofi -show drun
        ;;
    "windows")
        run rofi -show window
        ;;
    "command")
        run rofi -show run
        ;;
    "clipboard")
        # cliphist list | rofi -dmenu | cliphist decode | wl-copy &
        run rofi -modi "clipboard:$XDG_CONFIG_HOME/rofi/modes/clipboard.sh" -show clipboard
        ;;
    "emoji")
        run rofi -modi emoji -show emoji
        ;;
    "file-manager")
        run $FILE_MANAGER
        ;;
    "browser")
        run $BROWSER
        ;;
    "terminal")
        run $TERMINAL
        ;;
    "btop")
        run $TERMINAL btop
        ;;
    "nvtop")
        run $TERMINAL nvtop
        ;;
    "auto-cpufreq")
        run auto-cpufreq-gtk
        ;;
    "colorpicker")
        COLOR=$(hyprpicker -a -f hex)
        [[ -n "$COLOR" ]] && notify-send -a popup -t 5000 "Color copied" "󰏘  $COLOR" &
        ;;
    "gripper")
        run gripper $EXTRA_ARGS
        ;;
    "hyprmon")
        run hyprmon $EXTRA_ARGS
        ;;
esac
