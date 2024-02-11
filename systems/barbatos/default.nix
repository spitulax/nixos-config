{ lib
, pkgs
, outputs
, inputs
, config
, ...
}: {
  imports = [
    inputs.home-manager.nixosModules.home-manager
    inputs.nixos-hardware.nixosModules.common-cpu-intel
    inputs.nixos-hardware.nixosModules.common-gpu-intel
    inputs.nixos-hardware.nixosModules.common-pc-laptop
    inputs.nixos-hardware.nixosModules.common-pc-laptop-acpi_call
    inputs.nixos-hardware.nixosModules.common-pc-laptop-ssd
    ./hardware-configuration.nix
    ../global
    ../users/bintang.nix
  ] ++ (builtins.attrValues outputs.nixosModules);

  # Hardware
  hardware.enableRedistributableFirmware = true;
  boot.kernelModules = [ "synaptics_usb" ];
  services.thermald.enable = true;

  # Networking
  networking.hostName = "barbatos";
  networking.networkmanager.enable = true;

  # Display
  # @TODO: Add hyprland (see notes)
  services.xserver = {
    enable = true;
    displayManager.sddm.enable = true;
    displayManager.defaultSession = "plasma";
    desktopManager.plasma5.enable = true;
  };
  programs.xwayland.enable = true;
  xdg.portal.enable = true;

  # Misc services
  services.printing.enable = true;

  # Sounds
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  # State version
  system.stateVersion = "23.11";
}
