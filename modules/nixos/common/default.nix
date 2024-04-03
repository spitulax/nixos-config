{ pkgs
, inputs
, ...
}: {
  imports = [
    ./nix.nix
    ./bluetooth.nix
    ./flatpak.nix
    ./home-manager.nix
    ./security.nix
    ./sops.nix
    ./power.nix
    ./avahi.nix
    ./packages.nix
    ./locale.nix
    ./openssh.nix
  ];

  # FIXME: downgrade backdoored version of xz
  # temporary fix until #300028 is merged to nixos-unstable
  system.replaceRuntimeDependencies = [
    {
      original = pkgs.xz;
      replacement = pkgs.inputs.nixpkgs-unstable-small.xz;
    }
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
