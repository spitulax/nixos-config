{ config
, lib
, pkgs
, ...
}: {
  options.configs.steam.enable = lib.mkEnableOption "Steam";

  config = lib.mkIf config.configs.steam.enable {
    hardware.steam-hardware.enable = true;
    programs.steam = {
      enable = true;
      extraCompatPackages = [
        pkgs.proton-ge-bin
      ];
      protontricks.enable = true;
    };
  };
}
