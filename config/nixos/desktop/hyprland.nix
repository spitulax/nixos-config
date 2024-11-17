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
      };
      uwsm = {
        enable = true;
        waylandCompositors.hyprland = {
          binPath = "/run/current-system/sw/bin/Hyprland";
          prettyName = "Hyprland";
          comment = "Hyprland managed by UWSM";
        };
      };
    };

    security.pam.services = {
      # swaylock = { };
      hyprlock = { };
    };
  };
}
