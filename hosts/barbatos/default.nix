{ lib
, pkgs
, outputs
, inputs
, config
, ...
}: {
  imports = with inputs; [
    nixos-hardware.nixosModules.common-cpu-intel
    nixos-hardware.nixosModules.common-gpu-intel
    nixos-hardware.nixosModules.common-pc-laptop
    nixos-hardware.nixosModules.common-pc-laptop-acpi_call
    nixos-hardware.nixosModules.common-pc-laptop-ssd
    ./hardware-configuration.nix
  ] ++ (with outputs.nixosModules; [
    keymapper
    gaming
    video-hardware

    common
    desktop

    users.bintang
  ]);

  # Hardware
  hardware.enableRedistributableFirmware = true;
  boot.kernelModules = [ "synaptics_usb" ];
  services.thermald.enable = true;

  # Networking
  networking.hostName = "barbatos";

  # Misc programs
  environment.systemPackages = with pkgs; [
    # hardware monitoring
    inxi
    glxinfo
    lm_sensors
    libva-utils
    pciutils
    vdpauinfo
    intel-gpu-tools
    xorg.xdpyinfo
    powertop
    usbutils
  ];

  # Misc services
  services.printing.enable = false;

  # State version
  system.stateVersion = "23.11";
}
