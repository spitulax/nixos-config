{ config
, lib
, pkgs
, ...
}:
let
  cfg = config.configs.hotspot;
in
{
  options.configs.hotspot.enable = lib.mkEnableOption "hotspot (via linux-router)";

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      linux-router
      qrencode
    ];
  };
}
