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
    ./sound.nix
    ./sway.nix
  ];

  options.configs.desktop = {
    enable = mkEnableOption "desktop specific modules";
    environments = {
      hyprland = mkEnableOption "Hyprland";
      sway = mkEnableOption "Sway";
    };
    defaultSession = mkOption {
      type = types.nullOr (types.enum (builtins.attrNames cfg.environments));
      default = null;
      description = "The default desktop environment to log into.";
    };
  };

  config = lib.mkIf cfg.enable {
    programs.xwayland.enable = true;

    # Takes up a lot of space.
    services.speechd.enable = lib.mkForce false;
  };
}
