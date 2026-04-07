#!/usr/bin/env bash

set -euo pipefail

CHOICE="$(echo -en "Shutdown\nReboot\nLock\nExit" | tofi --prompt-text POWEROFF --config ~/.config/tofi/vertical)"
case "$CHOICE" in
    "Shutdown")
        systemctl poweroff
        ;;
    "Reboot")
        systemctl reboot
        ;;
    "Lock")
        swaylock &
        sleep 1
        systemctl suspend
        ;;
    "Exit")
        swaymsg exit
        ;;
    *)
        exit 1
        ;;
esac
