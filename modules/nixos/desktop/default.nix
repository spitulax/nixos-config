{ config
, pkgs
, inputs
, ...
}: {
  imports = [
    ./plasma.nix
    ./imgpreview.nix
    ./input.nix
    ./sound.nix
    ./opengl.nix
    ./fonts.nix
  ];

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [ xdg-desktop-portal-gtk ];
  };

  services.xserver = {
    enable = true;
    displayManager.sddm.enable = true;
    displayManager.defaultSession = "hyprland";
  };
  programs.xwayland.enable = true;

  programs.hyprland = {
    enable = true;
    package = pkgs.inputs.hyprland.hyprland;
    portalPackage = pkgs.inputs.hyprland.xdg-desktop-portal-hyprland;
  };

  security.pam.services.swaylock = { };
}
