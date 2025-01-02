{ config
, lib
, pkgs
, ...
}:
let
  cfg = config.configs.apps.electrum;
in
{
  options.configs.apps.electrum.enable = lib.mkEnableOption "Electrum";

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      electrum
    ];
  };
}
