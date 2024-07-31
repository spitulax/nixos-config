{ pkgs
, inputs
, myLib
, ...
}: myLib.importIn ./. // {

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

  services.speechd.enable = false;

  security.pam.services = {
    # swaylock = { };
    hyprlock = { };
  };
}
