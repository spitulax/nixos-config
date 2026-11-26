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
        # proton-ge-bin
        pkgs.tempPkgs.proton-wineland.proton-wineland-bin
      ];
      protontricks.enable = true;
    };
  };
}
