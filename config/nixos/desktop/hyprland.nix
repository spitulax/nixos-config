{ config
, lib
, pkgs
, ...
}: {
  config = lib.mkIf config.configs.desktop.environments.hyprland {
    programs.hyprland = with pkgs.inputs.hyprland; {
      enable = true;
      package = hyprland;
      portalPackage = xdg-desktop-portal-hyprland;
    };

    security.pam.services = {
      # swaylock = { };
      hyprlock = { };
    };
  };
}
