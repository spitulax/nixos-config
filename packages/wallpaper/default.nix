{ writeShellScriptBin }:
# TODO: maybe add alternating wallpapers if more than one files are defined in wallpaperrc
writeShellScriptBin "wallpaper" ''

# FIXME: See `users/bintang/barbatos.nix` for condition
# - press power button to go to sleep
# - close the lid
# - wake up from sleep and greeted with hyprlock
# - press power button from hyprlock
# - close the lid
# - wake up and unlock, wallpaper is not loaded and started from workspace 6

reload () {
  if [[ -r $HOME/.config/wallpaperrc ]]; then
    # Make sure the path in wallpaperrc is absolute
    swww img $(cat $HOME/.config/wallpaperrc)
  fi
}

usage () {
  echo "Change: wallpaper change <wallpaper>"
  echo "Reload: wallpaper"
  echo "Help:   wallpaper --help"
}

if [[ -z "$(pgrep swww-daemon)" ]]; then
  rm $XDG_RUNTIME_DIR/swww.socket # sometimes swww will not remove the socket
  swww-daemon -q &
fi

case $# in
2)
  case "$1" in
  "change")
    realpath $2 > $HOME/.config/wallpaperrc
    reload
    echo "Changed current wallpaper to $2"
  ;;
  *)
    usage
    exit 1
  esac
;;

0)
  case "$1" in
  "--help")
    usage
  ;;
  *)
    reload
    echo "Reloaded current wallpaper"
  esac
;;

*)
  usage
  exit 1
esac

''
