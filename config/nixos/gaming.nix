{ config
, lib
, pkgs
, inputs
, ...
}: {
  imports = [
    inputs.nix-gaming.nixosModules.pipewireLowLatency
    inputs.nix-gaming.nixosModules.platformOptimizations
  ];

  options.configs.gaming.enable = lib.mkEnableOption "gaming improvements";

  config = lib.mkIf config.configs.gaming.enable {
    # Gamemode
    programs.gamemode = {
      enable = true;
      settings.general.renice = 15;
    };

    # Gaming Kernel
    boot.kernelPackages = pkgs.linuxPackages_xanmod_latest;
    # environment.systemPackages = [ pkgs.scx ];

    # Misc
    programs.steam.platformOptimizations.enable = true;

    # Pipewire Low Latency
    services.pipewire = {
      lowLatency = {
        enable = true;
        quantum = 64;
        rate = 48000;
      };
    };
  };
}
