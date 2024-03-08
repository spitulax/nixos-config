{ config
, pkgs
, inputs
, ...
}: {
  imports = [
    ./plasma.nix
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

  services.tumbler.enable = true; # Thumbnail support for images
  environment.systemPackages = with pkgs; [
    # File preview
    webp-pixbuf-loader # .webp
    ffmpegthumbnailer # video
  ];
}
