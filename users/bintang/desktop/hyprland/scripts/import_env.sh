#!/usr/bin/env bash
set -e
[[ -n $HYPRLAND_DEBUG_CONF ]] && exit 0

_envs=(
  WAYLAND_DISPLAY
  DISPLAY
  USERNAME
  XDG_BACKEND
  XDG_CURRENT_DESKTOP
  XDG_SESSION_TYPE
  XDG_SESSION_ID
  XDG_SESSION_CLASS
  XDG_SESSION_DESKTOP
  XDG_SEAT
  XDG_VTNR
  HYPRLAND_CMD
  HYPRLAND_INSTANCE_SIGNATURE
  SWAYSOCK
  XCURSOR_SIZE
  _JAVA_AWT_WM_NOREPARENTING
  QT_QPA_PLATFORM
  QT_WAYLAND_DISABLE_WINDOWDECORATION
  GRIM_DEFAULT_DIR
  SSH_AUTH_SOCK
  NIXOS_OZONE_WL
  SDL_VIDEODRIVER
  GDK_BACKEND
  WALLPAPER
)

case "$1" in
system)
  dbus-update-activation-environment --systemd "${_envs[@]}"
  ;;
tmux)
  for v in "${_envs[@]}"; do
    if [[ -n ${!v} ]]; then
      tmux setenv -g "$v" "${!v}"
    fi
  done
  ;;
*)
  exit 1
  ;;
esac
