#!/usr/bin/env bash

# Wallpaper
if [[ ! -r $HOME/.config/hypr/hyprpaper.conf ]]; then
  WALLPAPER=$(cat $XDG_DATA_HOME/wallpaperrc)
  cat > $HOME/.config/hypr/hyprpaper.conf << EOF
preload = $WALLPAPER
wallpaper = ,$WALLPAPER
splash = false
ipc = false
EOF
  wallpaper restart
fi

# Autostart apps
$HOME/.nix-profile/libexec/polkit-kde-authentication-agent-1 &
$HOME/.config/hypr/scripts/waybar.sh

# Cliphist
wl-paste --type text --watch cliphist store &
wl-paste --type image --watch cliphist store &
