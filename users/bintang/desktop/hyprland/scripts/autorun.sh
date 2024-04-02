#!/usr/bin/env bash

hypridle &

# Display wallpaper
sleep 1
wallpaper

# Start waybar
pkill waybar
waybar &
sleep 2 # wait waybar to load

# Autostart apps
$HOME/.nix-profile/libexec/polkit-kde-authentication-agent-1 &
zapzap &
blueman-applet &
nm-applet &

# Cliphist
wl-paste --type text --watch cliphist store &
wl-paste --type image --watch cliphist store &
