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
    extraPortals = with pkgs; [ xdg-desktop-portal-gtk ];
  };

  programs.xwayland.enable = true;

  programs.hyprland = {
    enable = true;
    package = pkgs.inputs.hyprland.hyprland;
    portalPackage = pkgs.inputs.hyprland.xdg-desktop-portal-hyprland;
  };

  security.pam.services.swaylock = { };
}
