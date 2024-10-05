#!/usr/bin/env bash

notify () {
    notify-send -a popup -h string:x-canonical-private-synchronous:sys-notify "$1" "$2" &
}

usage () {
    echo "hyprmon [args...]"
    echo "Arguments:"
    echo -e "\t-i\n\t\tInteractive mode with rofi."
    echo -e "\t-n <monitor>\n\t\tName of the monitor to configure. Default is empty name."
    echo -e "\t-m <monitor|auto>\n\t\tName of the monitor to be mirrored. \`auto\` is the first monitor from \`hyprctl monitors\`."
    echo -e "\t-r <WxH|WxH@RR|preferred|highres|highrr>\n\t\tThe monitor's new resolution and refresh rate. Default is 'preferred'."
    echo -e "\t-p <XxY|auto|auto-right|auto-left|auto-up|auto-down>\n\t\tThe monitor's new position. Default is 'auto'."
    echo -e "\t-s <N|auto>\n\t\tThe monitor's new scale. Default is '1'."
    echo -e "\t-h\n\t\tDisplay this help."
}

RESOLUTION="preferred"
POSITION="auto"
SCALE="1"
INTERACTIVE=0

i=1
while [ $i -le $# ]; do
    case "${!i:0:2}" in
        "-h")
            usage
            exit 1
            ;;
        "-i")
            INTERACTIVE=1
            ;;
        "-n")
            i=$((i+1))
            NAME=${!i}
            ;;
        "-m")
            i=$((i+1))
            MIRROR=${!i}
            ;;
        "-r")
            i=$((i+1))
            RESOLUTION=${!i}
            ;;
        "-p")
            i=$((i+1))
            POSITION=${!i}
            ;;
        "-s")
            i=$((i+1))
            SCALE=${!i}
            ;;
    esac
    i=$((i+1))
done

if [ $INTERACTIVE -eq 1 ]; then
    [ $(command -v rofi) ] || (echo "rofi is not found." && exit 1)

    MONITORS=$(hyprctl monitors | awk '/^Monitor/ { print $2 }')
    NAME=$(echo -e "New\n${MONITORS}" | rofi -dmenu -p "Choose Monitor")
    [ -z "$NAME" ] && exit 1
    [ "$NAME" = "New" ] && NAME=""

    case "$(echo -e "Auto\nUp\nDown\nRight\nLeft\nMirror" | rofi -dmenu -p "Choose Monitor Position")" in
        "Auto")
            POSITION="auto"
            ;;
        "Up")
            POSITION="auto-up"
            ;;
        "Down")
            POSITION="auto-down"
            ;;
        "Right")
            POSITION="auto-right"
            ;;
        "Left")
            POSITION="auto-left"
            ;;
        "Mirror")
            MIRROR=$(echo -e "Auto\n$MONITORS" | rofi -dmenu -p "Choose Monitor To Be Mirrored")
            [ -z "$MIRROR" ] && exit 1
            [ "$MIRROR" = "Auto" ] && MIRROR="auto"
            ;;
    esac
    [ -z "$POSITION" ] && [ -z "$MIRROR" ] && exit 1
else
    if [ "$MIRROR" = "auto" ]; then
        MIRROR=$(hyprctl monitors | awk '/^Monitor/ { print $2 }' | head -n1)
    fi
fi

COMMAND="hyprctl keyword monitor ${NAME},${RESOLUTION},${POSITION},${SCALE}"
[ -n "$MIRROR" ] && COMMAND="${COMMAND},mirror,${MIRROR}"
[ $($COMMAND) != "ok" ] && exit 1
MESSAGE="Res: ${RESOLUTION}\nPos: ${POSITION}\nScale: ${SCALE}"
[ -n "$MIRROR" ] && MESSAGE="${MESSAGE}\nMirrors to: ${MIRROR}"
notify "󰍹   $([ -z "$NAME" ] && printf "New" || printf "$NAME")" "$MESSAGE"
