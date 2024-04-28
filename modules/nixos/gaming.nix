{ pkgs
, inputs
, ...
}: {
  imports = [
    inputs.nix-gaming.nixosModules.pipewireLowLatency
  ];

  # Gamemode
  programs.gamemode = {
    enable = true;
    settings.general.renice = 15;
  };
  boot.kernelModules = [ "linux_xanmod" ];

  # Steam
  hardware.steam-hardware.enable = true;
  programs.steam.enable = true;
  programs.steam.extraCompatPackages = [
    pkgs.proton-ge-bin
  ];

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
