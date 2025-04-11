{ config
, lib
, pkgs
, ...
}:
let
  cfg = config.configs.apps.gplates;
in
{
  options.configs.apps.gplates.enable = lib.mkEnableOption "GPlates";

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      gplates
    ];
  };
}
