{ lib
, pkgs
, outputs
, inputs
, config
, ...
}: {
  imports = [
    inputs.home-manager.nixosModules.home-manager
    # @TODO: inputs.nixos-hardware.nixosModules.
    ../global
    # @TODO: ./hardware-configuration.nix
    ../users/bintang.nix
  ] ++ (builtins.attrValues outputs.nixosModules);

  # Networking
  networking.hostName = "barbatos";
  networking.networkmanager.enable = true;

  # Display
  # @TODO: Add hyprland (see notes)
  services.xserver = {
    enable = true;
    displayManager.gdm.enable = true;
    displayManager.defaultSession = "plasma";
    desktopManager.plasma5.enable = true;
  };
  xdg.portal.enable = true;

  # State version
  system.stateVersion = "23.11";
}
