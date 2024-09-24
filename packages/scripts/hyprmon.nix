{ writeShellScriptBin }:
writeShellScriptBin "hyprmon" ''

notify () {
  notify-send -a popup -h string:x-canonical-private-synchronous:sys-notify "$1" "$2" &
}

usage () {
    echo "hyprmon [args...]"
    echo "Arguments:"
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

i=1
while [ $i -le $# ]; do
    case "''${!i:0:2}" in
        "-h")
            usage
            exit 1
            ;;
        "-n")
            i=$((i+1))
            NAME=''${!i}
            ;;
        "-m")
            i=$((i+1))
            MIRROR=''${!i}
            ;;
        "-r")
            i=$((i+1))
            RESOLUTION=''${!i}
            ;;
        "-p")
            i=$((i+1))
            POSITION=''${!i}
            ;;
        "-s")
            i=$((i+1))
            SCALE=''${!i}
            ;;
    esac
    i=$((i+1))
done

if [ "$MIRROR" = "auto" ]; then
    MIRROR=$(hyprctl monitors | awk '/^Monitor/ { print $2 }' | head -n1)
fi

COMMAND="hyprctl keyword monitor ''${NAME},''${RESOLUTION},''${POSITION},''${SCALE}"
[ -n "$MIRROR" ] && COMMAND="''${COMMAND},mirror,''${MIRROR}"
[ $($COMMAND) != "ok" ] && exit 1
MESSAGE="Res: ''${RESOLUTION}\nPos: ''${POSITION}\nScale: ''${SCALE}"
[ -n "$MIRROR" ] && MESSAGE="''${MESSAGE}\nMirrors to: ''${MIRROR}"
notify "󰍹   $([ -z "$NAME" ] && printf "New" || printf "$NAME")" "$MESSAGE"

''
