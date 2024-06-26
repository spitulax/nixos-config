{ pkgs
, outputs
, inputs
, ...
}: {
  imports = with inputs; [
    ./hardware-configuration.nix
    nixos-hardware.nixosModules.common-pc-laptop
    nixos-hardware.nixosModules.common-pc-laptop-acpi_call
    nixos-hardware.nixosModules.common-pc-laptop-ssd
    nixos-hardware.nixosModules.common-cpu-intel
    # FAILED: error: The option `hardware.intelgpu.loadInInitrd' in `/nix/store/gb7384izfb1x5i7vibr6ylazx8bf7bq6-source/hosts/barbatos' is already declared in `/nix/store/0ckkj733ppb5r4lq7m4m0y8g285s160q-source/common/gpu/intel'.
    # nixos-hardware.nixosModules.common-gpu-intel
  ] ++ (with outputs.nixosModules; [
    features.keymapper
    features.gaming
    features.video-hardware-intel
    features.warp
    features.vm

    common
    desktop
    laptop

    users.bintang
  ]);

  # Hardware
  hardware.enableRedistributableFirmware = true;
  boot.kernelModules = [ "synaptics_usb" ];
  boot.initrd.kernelModules = [ "i915" ];
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
    nvtopPackages.intel
    intel-gpu-tools
  ];

  # Misc services
  services.printing.enable = false;
  programs.gamemode = {
    settings = {
      general = {
        igpu_desiredgov = "performance";
        igpu_power_threshold = -1;
      };
    };
  };
  power.power-manager = {
    enable = true;
    program = "auto-cpufreq";
  };
  vm = {
    enable = true;
    waydroid = false;
    qemuAllArch = false;
  };

  # State version
  system.stateVersion = "23.11";
}
