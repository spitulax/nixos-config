{ config
, pkgs
, inputs
, ...
}: {
  imports = [
    ./imgpreview.nix
    ./input.nix
    ./sound.nix
    ./opengl.nix
    ./fonts.nix
    ./sddm.nix
  ];

  xdg.portal = {
    enable = true;
  };

  programs.xwayland.enable = true;

  programs.hyprland = with inputs.hyprland.packages.${pkgs.system}; {
    enable = true;
    package = hyprland;
    portalPackage = xdg-desktop-portal-hyprland;
  };

  security.pam.services.swaylock = { };
}
