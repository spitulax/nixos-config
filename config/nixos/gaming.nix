{ config
, lib
, pkgs
, inputs
, ...
}:
let
  cfg = config.configs.gaming;
in
{
  imports = [
    inputs.nix-gaming.nixosModules.platformOptimizations
  ];

  options.configs.gaming = {
    enable = lib.mkEnableOption "gaming improvements";
  };

  config = lib.mkIf cfg.enable {
    # Gamemode
    programs.gamemode = {
      enable = true;
      settings.general.renice = 15;
    };

    # Gaming Kernel
    # TEMP: kernel
    boot.kernelPackages = pkgs.linuxPackages_xanmod_latest;

    # Misc
    programs.steam.platformOptimizations.enable = true;
  };
}
