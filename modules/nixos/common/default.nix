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
      replacement = inputs.nixpkgs-staging-next.legacyPackages.${pkgs.system}.xz;
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
  services.dbus.packages = [ pkgs.gcr ];
  services.gvfs.enable = true;
  services.udisks2.enable = true;
}
