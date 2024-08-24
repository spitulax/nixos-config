{ config
, pkgs
, myLib
, lib
, ...
}:
let
  inherit (lib)
    mkEnableOption
    mkOption
    types
    ;

  cfg = config.configs.desktop;
in
{
  imports = myLib.importIn ./.;

  options.configs.desktop = {
    enable = mkEnableOption "desktop specific modules";
    environments = {
      hyprland = mkEnableOption "Hyprland";
      plasma = mkEnableOption "KDE Plasma";
    };
    defaultSession = mkOption {
      type = types.nullOr (types.enum (builtins.attrNames cfg.environments));
      description = "The default desktop environment to log into.";
    };
  };

  config = lib.mkIf cfg.enable {
    programs.xwayland.enable = true;

    xdg.portal = {
      enable = true;
      extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    };

    services.speechd.enable = false;
  };
}
