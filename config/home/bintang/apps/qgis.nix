{ config
, lib
, pkgs
, ...
}:
let
  cfg = config.configs.apps.qgis;
in
{
  options.configs.apps.qgis.enable = lib.mkEnableOption "QGIS";

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      qgis
    ];
  };
}
