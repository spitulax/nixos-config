{ outputs
, inputs
, ...
}: {
  imports = with inputs; [
    ./hardware-configuration.nix
    nixos-hardware.nixosModules.common-pc-laptop
    nixos-hardware.nixosModules.common-pc-laptop-acpi_call
    nixos-hardware.nixosModules.common-pc-laptop-ssd
    nixos-hardware.nixosModules.common-cpu-intel
    nixos-hardware.nixosModules.common-gpu-intel
    outputs.nixosConfigModule
  ];

  # Config modules
  configs = {
    hostName = "barbatos";

    desktop = {
      enable = true;
      environments.hyprland = true;
      defaultSession = "hyprland";
    };
    laptop.enable = true;
    gaming.enable = true;
    keymapper.enable = true;
    steam.enable = false;
    tablet.enable = true;
    vm.enable = true;
    warp.enable = true;
    powerManager = {
      enable = true;
      program = "auto-cpufreq";
    };
    hardware.intel.enable = true;

    users = [
      "bintang"
    ];
  };

  # Hardware
  hardware.enableRedistributableFirmware = true;
  boot.kernelModules = [ "synaptics_usb" ];
  boot.initrd.kernelModules = [ "i915" ];
  services.thermald.enable = true;
  boot.extraModprobeConfig = ''
    options kvm_intel nested=1
    options rfkill master_switch_mode=2
  '';

  # Misc services
  programs.gamemode = {
    settings = {
      general = {
        igpu_desiredgov = "performance";
        igpu_power_threshold = -1;
      };
    };
  };
}
