#!/usr/bin/env bash

notify () {
    notify-send -a popup -h string:x-canonical-private-synchronous:sys-notify "$1" "$2" &
}

case "$(echo -e "Default\nPowersave\nPerformance" | rofi -dmenu -p "Choose Governor")" in
    "Default")
        kdesu auto-cpufreq -- --force reset
        notify "󰾅" "Default"
        ;;
    "Powersave")
        kdesu auto-cpufreq -- --force powersave
        notify "󰾆" "Powersave"
        ;;
    "Performance")
        kdesu auto-cpufreq -- --force performance
        
        notify "󰓅" "Performance"
        ;;
    "")
        exit 1
        ;;
esac
