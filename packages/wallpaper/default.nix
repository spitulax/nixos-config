{ writeShellScriptBin }:
# TODO: maybe add alternating wallpapers if more than one files are defined in wallpaperrc
writeShellScriptBin "wallpaper" ''
  [[ -z "$(pgrep swww-daemon)" ]] && swww init
  if [[ -r $HOME/.config/wallpaperrc ]]; then
    swww img $(cat $HOME/.config/wallpaperrc)
  fi
''
