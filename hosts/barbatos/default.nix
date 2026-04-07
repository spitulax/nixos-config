{ inputs
, ...
}: {
  imports = with inputs; [
    ./hardware-configuration.nix
    nixos-hardware.nixosModules.common-pc-laptop
    nixos-hardware.nixosModules.common-pc-laptop-ssd
    nixos-hardware.nixosModules.common-cpu-intel
    nixos-hardware.nixosModules.common-gpu-intel
  ];

  # Config modules
  configs = {
    desktop = {
      enable = true;
      environments = {
        sway = true;
      };
      fonts = {
        cjkFonts = true;
        nerdFonts = true;
        notoFonts = true;
        # ISSUE: The font looks wonky (specifically) on Brave
        # defaultFonts.sansSerif = [{
        #   name = "Fira Sans";
        #   package = pkgs.fira;
        # }];
      };
    };
    laptop.enable = true;
    openssh.addHostKeys = true;
    gaming.enable = true;
    keymapper.enable = false;
    steam.enable = true;
    tablet.enable = true;
    vm = {
      qemu = false;
      waydroid = false;
    };
    warp.enable = false;
    powerManager = {
      enable = true;
      program = "auto-cpufreq";
    };
    hardware.intel.enable = true;
    sops.enable = true;
    perf.enable = true;
    docker.enable = false;
    keyd.enable = true;
    sql.enable = false;
    hotspot.enable = true;
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
