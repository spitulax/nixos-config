{ writeShellScriptBin }:
writeShellScriptBin "autorun"
  (''
    set -euo pipefail
  '' + ''
    killall .blueman-applet; blueman-applet &
    killall .nm-applet-wrap; nm-applet &
  '' + ''
    systemctl --user start waybar.service
  '' + ''
    systemctl --user start hyprswitch.service
  '')
