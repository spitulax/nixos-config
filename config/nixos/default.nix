{ config
, lib
, hostname
, ...
}:
let
  inherit (lib)
    mkOption
    types
    ;

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

  options.configs = {
    extraPackages = mkOption {
      type = types.listOf types.package;
      default = [ ];
      description = "Extra packages to be included with system packages.";
    };

    hostname = mkOption {
      type = types.str;
      default = hostname;
      readOnly = true;
      description = "The system's host name.";
    };

    stateVersion = mkOption {
      type = types.str;
      default = "23.11";
      description = "Configuration state version.";
    };
  };

  config = {
    networking.hostName = cfg.hostname;
    system.stateVersion = cfg.stateVersion;
  };
}
