{ config
, lib
, pkgs
, ...
}:
let
  cfg = config.configs.apps.media;
in
{
  options.configs.apps.media = {
    mpv = lib.mkEnableOption "mpv media player";
    nomacs = lib.mkEnableOption "nomacs image viewer";
  };

  config = {
    programs.mpv = {
      enable = cfg.mpv;
      config = {
        hwdec = "auto-safe";
      };
    };

    home.packages = lib.optionals cfg.nomacs [
      pkgs.nomacs
    ];
  };
}
