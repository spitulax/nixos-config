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
  programs.xwayland.enable = true;

  programs.hyprland = {
    enable = true;
    portalPackage = pkgs.xdg-desktop-portal-hyprland;
    package = inputs.hyprland.packages.${pkgs.system}.hyprland;
  };

  environment.systemPackages = with pkgs; [
    swaylock

    # Bar
    waybar
    # eww # TODO: Configure eww

    # Notif daemon
    dunst
    libnotify

    # Wallpaper
    swww

    # Launcher/Picker
    wofi
    rofimoji

    # Screenshot
    flameshot
    grim
  ];

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1"; # Hint electron apps to use wayland
  };
}
