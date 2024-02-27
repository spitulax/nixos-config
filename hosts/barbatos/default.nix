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
    ../global/desktop.nix

    # Optional features
    ../features/desktop.nix
    ../features/gaming.nix
    ../features/keymapper.nix
    ../features/home-manager.nix
    ../features/sops.nix

    # Users
    ../users/bintang.nix
  ] ++ (builtins.attrValues outputs.nixosModules);

  # Hardware
  hardware.enableRedistributableFirmware = true;
  boot.kernelModules = [ "synaptics_usb" ];
  services.thermald.enable = true;
  hardware.videoAccel.enable = true;

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
  ];

  # Misc services
  services.printing.enable = false;

  # State version
  system.stateVersion = "23.11";
}
