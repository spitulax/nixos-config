{ config
, lib
, pkgs
, ...
}: {
  config = lib.mkIf config.configs.desktop.environments.hyprland {
    programs = {
      hyprland = with pkgs.inputs.hyprland; {
        enable = true;
        package = hyprland;
        portalPackage = xdg-desktop-portal-hyprland;
        withUWSM = true;
      };
      uwsm.waylandCompositors.hyprland.binPath = lib.mkForce "/run/current-system/sw/bin/start-hyprland";
    };

    xdg.portal = {
      enable = true;
      extraPortals = [ pkgs.kde.xdg-desktop-portal-kde ];
      config.hyprland = {
        default = [ "hyprland" "kde" ];
      };
    };

    security.pam.services = {
      # swaylock = { };
      hyprlock = { };
    };
  };
}
