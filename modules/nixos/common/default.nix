{ pkgs
, ...
}: {
  imports = [
    ./nix.nix
    ./bluetooth.nix
    ./home-manager.nix
    ./security.nix
    ./sops.nix
    ./power.nix
    ./packages.nix
    ./locale.nix
    ./openssh.nix
  ];

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
}
