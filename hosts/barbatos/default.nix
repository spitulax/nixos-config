{ pkgs
, outputs
, inputs
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
    vm

    common
    desktop
    laptop

    users.bintang
  ]);

  # Hardware
  hardware.enableRedistributableFirmware = true;
  boot.kernelModules = [ "synaptics_usb" ];
  services.thermald.enable = true;
  boot.extraModprobeConfig = ''
    options kvm_intel nested=1
    options rfkill master_switch_mode=2
  '';

  # Networking
  networking.hostName = "barbatos";

  # Misc programs
  environment.systemPackages = with pkgs; [
    # hardware monitoring
    nvtop-intel
    libva-utils
    vdpauinfo
    intel-gpu-tools
  ];

  # Misc services
  services.printing.enable = false;
  programs.gamemode = {
    settings = {
      general = {
        igpu_desiredgov = "performance";
        igpu_power_threshold = -1;
        renice = 15;
      };
    };
  };

  # State version
  system.stateVersion = "23.11";
}
