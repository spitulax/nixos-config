{ config
, lib
, pkgs
, ...
}: {
  config = lib.mkIf config.configs.desktop.environments.sway {
    programs.sway = {
      enable = true;
      wrapperFeatures.gtk = true;
    };

    xdg.portal = {
      enable = true;
      extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
      wlr.enable = true;
    };

    security.pam.services = {
      swaylock = { };
    };
  };
}
