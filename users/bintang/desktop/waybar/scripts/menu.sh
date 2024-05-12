#!/usr/bin/env bash

# My little neofetch on the bar :)

time_since_fmt () {
  TIME=$(($(date +%s) - $1))
  TIME_Y=$((10#$(date "+%Y" -d "@$TIME") - 1970))
  TIME_M=$((10#$(date "+%m" -d "@$TIME") - 1))
  TIME_D=$((10#$(date "+%d" -d "@$TIME") - 1))
  TIME_H=$((10#$(date "+%H" -d "@$TIME")))
  TIME_MI=$((10#$(date "+%M" -d "@$TIME")))
  TIME_FULL=$(printf "%sh %smin" "$TIME_H" "$TIME_MI")
  [[ $TIME_D > 0 ]] && TIME_FULL=$(printf "%sd %s" "$TIME_D" "$TIME_FULL")
  [[ $TIME_M > 0 ]] && TIME_FULL=$(printf "%smo %s" "$TIME_M" "$TIME_FULL")
  [[ $TIME_Y > 0 ]] && TIME_FULL=$(printf "%sy %s" "$TIME_Y" "$TIME_FULL")
  echo "$TIME_FULL"
}

export TZ='Etc/UTC'
UPTIME=$(time_since_fmt $(cat /proc/stat | grep btime | awk '{print $2}'))
AGE=$(time_since_fmt $(stat -c %W /))

DISK_USED=$(df -h --total | tail -1 | awk '{print $3}')
DISK_AVAIL=$(df -h --total | tail -1 | awk '{print $4}')
DISK_AVAIL_P=$(df -h --total | tail -1 | awk '{print $5}')

TOOLTIP=$(printf "Uptime: %s\\\\nAge: %s\\\\nLinux: %s\\\\nNixOS: %s\\\\nHyprland: %s\\\\nWaybar: %s\\\\nDisk: %s" \
  "$UPTIME" \
  "$AGE" \
  "$(uname -r)" \
  "$(nixos-version)" \
  "$(readlink -f $(which Hyprland) | sed 's/^.*hyprland-\(.*\)\/bin\/.*/\1/')" \
  "$(readlink -f $(which waybar) | sed 's/^.*waybar-\(.*\)\/bin\/.*/\1/')" \
  "$DISK_USED : $DISK_AVAIL ($DISK_AVAIL_P)" \
  )
printf '{"text":"","tooltip":"%s"}' "$TOOLTIP"
