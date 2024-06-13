{ pkgs
, inputs
, ...
}: {
  imports = [
    inputs.nix-gaming.nixosModules.pipewireLowLatency
    inputs.nix-gaming.nixosModules.platformOptimizations
  ];

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
  # FAILED: {https://github.com/fufexan/nix-gaming/issues/161}
  # services.pipewire = {
  #   lowLatency = {
  #     enable = true;
  #     quantum = 64;
  #     rate = 48000;
  #   };
  # };
}
