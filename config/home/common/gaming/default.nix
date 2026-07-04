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
    ./steam
    ./emulators
    ./games.nix
    ./lutris.nix
  ];

  options.configs.gaming.misc.enable = lib.mkEnableOption "miscellaneous packages";

  config = lib.mkIf cfg.misc.enable {
    home.packages = with pkgs; [
      mangohud
    ];
  };
}
