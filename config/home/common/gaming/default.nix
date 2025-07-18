{ config
, lib
, pkgs
, ...
}:
let
  cfg = config.configs.gaming;
in
{
  imports = [
    ./games.nix
    ./lutris.nix
    ./pcsx2.nix
  ];

  options.configs.gaming.misc.enable = lib.mkEnableOption "miscellaneous packages";

  config = lib.mkIf cfg.misc.enable {
    home.packages = with pkgs; [
      mangohud
      gamescope
    ];
  };
}
