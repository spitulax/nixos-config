{ pkgs
, inputs
, ...
}: {
  imports = [
    ./input.nix
    ./sound.nix
    ./opengl.nix
    ./fonts.nix
    ./display-manager.nix
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
  };

  security.pam.services = {
    # swaylock = { };
    hyprlock = { };
  };
}
