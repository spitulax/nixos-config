#!/usr/bin/env bash

get () {
    BRIGHTNESS=$(brightnessctl info | awk 'NR==2 { print $4 }' | sed -r 's/\((.*)%\)/\1/')
    if [ $BRIGHTNESS -lt 25 ]; then
        printf "󰃞"
    elif [ $BRIGHTNESS -lt 50 ]; then
        printf "󰃟"
    elif [ $BRIGHTNESS -lt 75 ]; then
        printf "󰃝"
    else
        printf "󰃠"
    fi
    echo "  $BRIGHTNESS%"
}

notify () {
    notify-send -a popup -h string:x-canonical-private-synchronous:sys-notify "Brightness" "$(get)" &
}

case "$1" in
    "get")
        get
        ;;
    "inc")
        brightnessctl set 5%+ && notify
        ;;
    "dec")
        brightnessctl set 5%- && notify
        ;;
esac
