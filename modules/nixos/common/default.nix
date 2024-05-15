{ pkgs
, myLib
, ...
}: myLib.importIn ./. // {

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
