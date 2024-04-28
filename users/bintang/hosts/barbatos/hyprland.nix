{ config
, ...
}: {
  wayland.windowManager.hyprland = {
    settings = {
      monitor = "eDP-1,preferred,auto,1";
    };
    extraConfig = ''
      bindl = , switch:Lid Switch, exec, pidof hyprlock || hyprlock
      bindl = , switch:on:Lid Switch, exec, hyprctl keyword monitor "eDP-1,disable"
      bindl = , switch:off:Lid Switch, exec, hyprctl keyword monitor "${config.wayland.windowManager.hyprland.settings.monitor}"
    '';
  };
}
