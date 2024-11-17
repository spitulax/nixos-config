{ config
, lib
, pkgs
, ...
}:
let
  cfg = config.configs.apps.obsidian;
in
{
  options.configs.apps.obsidian.enable = lib.mkEnableOption "Obsidian";

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      obsidian
    ];
  };
}
