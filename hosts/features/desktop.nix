{ config
, pkgs
, inputs
, ...
}: {
  imports = [
    ./apps/thunar.nix
    ./plasma.nix
  ];

  xdg.portal = {
    enable = true;
  };

  services.xserver = {
    enable = true;
    desktopManager.plasma5.enable = true;

    displayManager.sddm.enable = true;
    displayManager.defaultSession = "plasma";
  };
}
