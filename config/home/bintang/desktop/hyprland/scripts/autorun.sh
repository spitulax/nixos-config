#!/usr/bin/env bash

# Autostart apps
$HOME/.nix-profile/libexec/polkit-kde-authentication-agent-1 &
$HOME/.config/hypr/scripts/waybar.sh

# Cliphist
wl-paste --type text --watch cliphist store &
wl-paste --type image --watch cliphist store &
