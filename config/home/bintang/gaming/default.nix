{ config
, lib
, myLib
, pkgs
, ...
}:
let
  cfg = config.configs.gaming;
in
{
  imports = myLib.importIn ./.;

  options.configs.gaming.misc.enable = lib.mkEnableOption "miscellaneous packages";

  config = lib.mkIf cfg.misc.enable {
    home.packages = with pkgs; [
      mangohud
      gamescope
    ];
  };
}
