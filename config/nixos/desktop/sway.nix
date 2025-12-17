{ config
, lib
, ...
}: {
  config = lib.mkIf config.configs.desktop.environments.sway {
    programs.sway = {
      enable = true;
      wrapperFeatures.gtk = true;
    };

    xdg.portal = {
      enable = true;
    };

    security.pam.services = {
      swaylock = { };
    };
  };
}
