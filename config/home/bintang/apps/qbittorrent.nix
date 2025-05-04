{ config
, lib
, pkgs
, ...
}:
let
  cfg = config.configs.apps.qbittorrent;
in
{
  options.configs.apps.qbittorrent.enable = lib.mkEnableOption "qBittorrent";

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      qbittorrent
    ];
  };
}
