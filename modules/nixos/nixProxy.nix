{ config
, lib
, ...
}:
let
  cfg = config.nixProxy;
in
{
  options = {
    nixProxy = {
      enable = lib.mkEnableOption "nixProxy";
    };
  };

  config = lib.mkIf cfg.enable {
    systemd.services.nix-daemon.environment = {
      https_proxy = "socks5h://localhost:7891";
    };
  };
}
