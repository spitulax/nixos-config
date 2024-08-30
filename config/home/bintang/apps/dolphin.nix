{ config
, lib
, pkgs
, ...
}: {
  options.configs.apps.dolphin.enable = lib.mkEnableOption "Dolphin file manager";

  config = lib.mkIf config.configs.apps.dolphin.enable {
    home.packages = with pkgs.libsForQt5; [
      dolphin
      ffmpegthumbs
      kio-extras
    ];
  };
}
