{ lib
, pkgs
, outputs
, inputs
, config
, ...
}: {
  imports = [
    inputs.home-manager.nixosModules.home-manager
    ../global
    ./hardware-configuration.nix
    ../users/bintang.nix
  ] ++ (builtins.attrValues outputs.nixosModules);

  # Networking
  networking.hostName = "astaroth";
  networking.networkmanager.enable = true;

  # Display
  services.xserver = {
    enable = true;
    displayManager.gdm.enable = true;
    displayManager.defaultSession = "plasma";
    desktopManager.plasma5.enable = true;
  };
  xdg.portal.enable = true;

  # Virtualization
  virtualisation.vmware.guest.enable = true;

  # State version
  system.stateVersion = "23.11";
}
