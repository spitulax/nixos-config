{ config
, lib
, ...
}:
let
  cfg = config.configs.apps.mpv;
in
{
  options.configs.apps.mpv.enable = lib.mkEnableOption "mpv media player";

  config = lib.mkIf cfg.enable {
    programs.mpv = {
      enable = true;
      config = {
        hwdec = "auto-safe";
      };
    };
  };
}
