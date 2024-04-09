{ writeShellScriptBin }:
# TODO: maybe add alternating wallpapers
writeShellScriptBin "wallpaper" ''

usage () {
  echo "Change:               wallpaper change <wallpaper>"
  echo "(Re)start hyprpaper:  wallpaper restart"
  echo "Help:                 wallpaper --help"
}

restart () {
  [[ -n $(pidof hyprpaper) ]] && killall hyprpaper
  hyprpaper >/dev/null &
}

change () {
  WALLPAPER=$(realpath "$1")
  cat > $HOME/.config/hypr/hyprpaper.conf << EOF
preload = $WALLPAPER
wallpaper = ,$WALLPAPER
splash = false
ipc = false
EOF
  restart
  echo "Changed current wallpaper to $1"
}

case $# in
2)
  case "$1" in
  "change")
    change "$2"
  ;;
  *)
    usage
    exit 1
  esac
;;

1)
  case "$1" in
  "--help")
    usage
  ;;
  "restart")
    restart
  ;;
  *)
    usage
    exit 1
  esac
;;

*)
  usage
  exit 1
esac

''
