{ config
, pkgs
, myLib
, lib
, ...
}: {
  imports = myLib.importIn ./.;

  options.configs.desktop.enable = lib.mkEnableOption "desktop specific modules";

  config = lib.mkIf config.configs.desktop.enable {
    programs.xwayland.enable = true;

    programs.hyprland = with pkgs.inputs.hyprland; {
      enable = true;
      package = hyprland;
      portalPackage = xdg-desktop-portal-hyprland;
    };

    xdg.portal = {
      enable = true;
      extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    };

    services.speechd.enable = false;

    security.pam.services = {
      # swaylock = { };
      hyprlock = { };
    };
  };
}
