{ config
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
  imports = [
    ./bluetooth.nix
    ./display-manager.nix
    ./fonts.nix
    ./hyprland.nix
    ./input.nix
    ./opengl.nix
    ./plasma.nix
    ./sound.nix
  ];

  options.configs.desktop = {
    enable = mkEnableOption "desktop specific modules";
    environments = {
      hyprland = mkEnableOption "Hyprland";
      plasma = mkEnableOption "KDE Plasma";
    };
    defaultSession = mkOption {
      type = types.nullOr (types.enum (builtins.attrNames cfg.environments));
      default = null;
      description = "The default desktop environment to log into.";
    };
  };

  config = lib.mkIf cfg.enable {
    programs.xwayland.enable = true;

    services.speechd.enable = false;
  };
}
