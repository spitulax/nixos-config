{ config
, lib
, pkgs
, ...
}: {
  options.configs.gaming.emulators.pcsx2.enable = lib.mkEnableOption "PCSX2";

  config = lib.mkIf config.configs.gaming.emulators.pcsx2.enable {
    home.packages = with pkgs; [
      pcsx2
    ];
  };
}
