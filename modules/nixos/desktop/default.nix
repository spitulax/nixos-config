{ pkgs
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

  programs.xwayland.enable = true;

  programs.hyprland = with inputs.hyprland.packages.${pkgs.system}; {
    enable = true;
    package = hyprland;
    portalPackage = xdg-desktop-portal-hyprland;
  };

  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    config.Hyprland = {
      default = [ "gtk" "hyprland" ];
    };
  };

  security.pam.services = {
    swaylock = { };
    hyprlock = { };
  };
}
