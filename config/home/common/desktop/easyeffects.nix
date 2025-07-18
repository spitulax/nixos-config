{ config
, lib
, pkgs
, ...
}:
let
  cfg = config.configs.desktop.easyeffects;
in
{
  options.configs.desktop.easyeffects.enable = lib.mkEnableOption "easyeffects";

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      easyeffects
    ];
  };
}
