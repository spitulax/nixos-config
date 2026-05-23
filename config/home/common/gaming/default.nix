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
    ./emulators
    ./games.nix
    ./lutris.nix
    ./steam.nix
  ];

  options.configs.gaming.misc.enable = lib.mkEnableOption "miscellaneous packages";

  config = lib.mkIf cfg.misc.enable {
    home.packages = with pkgs; [
      mangohud
    ];
  };
}
