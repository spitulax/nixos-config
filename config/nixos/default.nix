{ config
, ...
}:
let
  cfg = config.configs;
in
{
  imports = [
    ./common
    ./desktop
    ./hardware
    ./keyd
    ./laptop
    ./server
    ./avahi.nix
    ./docker.nix
    ./gaming.nix
    ./hotspot.nix
    ./keymapper.nix
    ./perf.nix
    ./power-manager.nix
    ./printing.nix
    ./sops.nix
    ./sql.nix
    ./steam.nix
    ./tablet.nix
    ./vm.nix
    ./warp.nix
    ./wireshark.nix
    ./zram.nix
  ];

  # Default options defined in `lib/extra.nix`.

  config = {
    networking.hostName = cfg.hostname;
    system.stateVersion = cfg.stateVersion;
  };
}
