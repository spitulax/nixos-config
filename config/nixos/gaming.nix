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
    inputs.nix-gaming.nixosModules.pipewireLowLatency
    inputs.nix-gaming.nixosModules.platformOptimizations
  ];

  options.configs.gaming = {
    enable = lib.mkEnableOption "gaming improvements";
    pipewire.quantum = lib.mkOption {
      type = lib.types.ints.unsigned;
      default = 128;
      description = ''
        Quantum rate over 48000 Hz.
        Higher means higher latency but less performance demand.

        Pipewire sends audio data to audio devices at the rate of quantum/480000 Hz.
        If the sound processing is slower, pipewire will still send the data at the same rate.
        This will result in incomplete data getting sent to the device, usually noticable as crackling sounds.
        Increasing the rate increases the time pipewire needs to wait before sending data into the device.
      '';
    };
  };

  config = lib.mkIf config.configs.gaming.enable {
    # Gamemode
    programs.gamemode = {
      enable = true;
      settings.general.renice = 15;
    };

    # Gaming Kernel
    boot.kernelPackages = pkgs.linuxPackages_xanmod_latest;

    # Misc
    programs.steam.platformOptimizations.enable = true;

    # Pipewire Low Latency
    services.pipewire = {
      lowLatency = {
        inherit (cfg.pipewire) quantum;
        enable = true;
        rate = 48000;
      };
    };
  };
}
