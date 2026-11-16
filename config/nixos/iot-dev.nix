{ config
, lib
, pkgs
, ...
}:
let
  cfg = config.configs.iotDev;
in
{
  options.configs.iotDev.enable = lib.mkEnableOption "IoT development environment";

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      clang-tools
      platformio-core
    ];

    services.udev.packages = with pkgs; [
      platformio-core.udev
    ];
  };
}
