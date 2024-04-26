#!/usr/bin/env bash

export TZ='Etc/UTC'
UPTIME=$(echo $(($(date +%s) - $(cat /proc/stat | grep btime | awk '{print $2}'))))
UPTIME_Y=$((10#$(date "+%Y" -d "@$UPTIME") - 1970))
UPTIME_M=$((10#$(date "+%m" -d "@$UPTIME") - 1))
UPTIME_D=$((10#$(date "+%d" -d "@$UPTIME") - 1))
UPTIME_H=$((10#$(date "+%H" -d "@$UPTIME")))
UPTIME_MI=$((10#$(date "+%M" -d "@$UPTIME")))
UPTIME_FULL=$(printf "%sh %smin" "$UPTIME_H" "$UPTIME_MI")
[[ $UPTIME_D > 0 ]] && UPTIME_FULL=$(printf "%sd %s" "$UPTIME_D" "$UPTIME_FULL")
[[ $UPTIME_M > 0 ]] && UPTIME_FULL=$(printf "%smo %s" "$UPTIME_M" "$UPTIME_FULL")
[[ $UPTIME_Y > 0 ]] && UPTIME_FULL=$(printf "%sy %s" "$UPTIME_Y" "$UPTIME_FULL")

DISK_USED=$(df -h --total | tail -1 | awk '{print $3}')
DISK_AVAIL=$(df -h --total | tail -1 | awk '{print $4}')
DISK_AVAIL_P=$(df -h --total | tail -1 | awk '{print $5}')

TOOLTIP=$(printf "Uptime: %s\\\\nLinux: %s\\\\nNixOS: %s\\\\nHyprland: %s\\\\nWaybar: %s\\\\nDisk: %s" \
  "$UPTIME_FULL" \
  "$(uname -r)" \
  "$(nixos-version)" \
  "$(readlink -f $(which Hyprland) | sed 's/^.*hyprland-\(.*\)\/bin\/.*/\1/')" \
  "$(readlink -f $(which waybar) | sed 's/^.*waybar-\(.*\)\/bin\/.*/\1/')" \
  "$DISK_USED : $DISK_AVAIL ($DISK_AVAIL_P)" \
  )
echo '{"text":"","tooltip":'"\"$TOOLTIP\"}"
