{ config
, lib
, pkgs
, ...
}:
let
  cfg = config.configs.gaming;
in
{
  options.configs.gaming = {
    enable = lib.mkEnableOption "gaming improvements";
  };

  config = lib.mkIf cfg.enable {
    configs.steam.enable = lib.mkDefault true;

    # Gamemode
    programs.gamemode = {
      enable = true;
      settings.general.renice = 15;
    };

    environment.systemPackages = with pkgs; [
      gamescope
    ];

    # Gaming Kernel
    boot.kernelPackages = pkgs.linuxPackages_xanmod_latest;

    # Optimization
    # Taken from https://github.com/fufexan/nix-gaming/blob/master/modules/platformOptimizations.nix
    boot.kernel.sysctl = {
      "kernel.sched_cfs_bandwidth_slice_us" = 3000;
      "net.ipv4.tcp_fin_timeout" = 5;
      "kernel.split_lock_mitigate" = 0;
      "vm.max_map_count" = 2147483642;
    };
  };
}
