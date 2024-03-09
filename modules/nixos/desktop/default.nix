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
  ];

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [ xdg-desktop-portal-gtk ];
  };

  services.xserver = {
    enable = true;
    displayManager.sddm.enable = true;
    displayManager.defaultSession = "plasmawayland";
  };
  programs.xwayland.enable = true;

  programs.hyprland = {
    enable = true;
    portalPackage = pkgs.xdg-desktop-portal-hyprland;
    package = inputs.hyprland.packages.${pkgs.system}.hyprland;
  };
}
