{ config
, pkgs
, lib
, ...
}:
{
  imports = [
    ./home-manager.nix
    ./locale.nix
    ./nix.nix
    ./openssh.nix
    ./packages.nix
    ./security.nix
  ];

  options.configs.common.enable = lib.mkEnableOption "common modules" // { default = true; };

  config = lib.mkIf config.configs.common.enable {
    # Bootloader
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    # Networking
    networking.networkmanager.enable = true;

    # Sudo
    security.sudo = {
      execWheelOnly = true;
    };

    # Services
    services = {
      dbus.packages = [ pkgs.gcr ];
      gvfs.enable = true;
      udisks2.enable = true;
    };

    # Misc.
    users.mutableUsers = false;
  };
}
