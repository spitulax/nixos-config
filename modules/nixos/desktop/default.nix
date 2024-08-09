{ pkgs
, myLib
, ...
}: myLib.importIn ./. // {

  programs.xwayland.enable = true;

  programs.hyprland = with pkgs.inputs.hyprland; {
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
