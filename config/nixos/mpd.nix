{ config
, lib
, ...
}:
let
  cfg = config.configs.mpd;
in
{
  options.configs.mpd.enable = lib.mkEnableOption "Music Player Daemon";

  config = lib.mkIf cfg.enable {
    services.mpd = {
      enable = true;
      startWhenNeeded = true;
      settings.bind_to_address = "any";
    };
  };
}
