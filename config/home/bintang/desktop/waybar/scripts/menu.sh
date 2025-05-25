#!/usr/bin/env bash

# My little neofetch on the bar :)

DISK_USED=$(df -h --total | tail -1 | awk '{print $3}')
DISK_AVAIL=$(df -h --total | tail -1 | awk '{print $4}')
DISK_AVAIL_P=$(df -h --total | tail -1 | awk '{print $5}')

TOOLTIP=$(printf "Uptime: %s\\\\nAge: %s\\\\nLinux: %s\\\\nNixOS: %s\\\\nHyprland: %s\\\\nWaybar: %s\\\\nDisk: %s" \
  "$(timeinfo uptime)" \
  "$(timeinfo age)" \
  "$(uname -r)" \
  "$(nixos-version)" \
  "$(readlink -f $(which Hyprland) | sed 's/^.*hyprland-\(.*\)\/bin\/.*/\1/')" \
  "$(readlink -f $(which waybar) | sed 's/^.*waybar-\(.*\)\/bin\/.*/\1/')" \
  "$DISK_USED : $DISK_AVAIL ($DISK_AVAIL_P)" \
  )
printf '{"text":"","tooltip":"%s"}' "$TOOLTIP"
