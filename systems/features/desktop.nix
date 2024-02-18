{ config
, pkgs
, ...
}: {
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
  };

  environment.systemPackages = with pkgs; [
    # Bar
    (waybar.overrideAttrs (oldAttrs: {
        mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
      })
    )
    # eww # TODO: Configure eww

    # Notif daemon
    dunst
    libnotify

    # Wallpaper
    swww

    # Launcher/Picker
    rofi-wayland
    rofimoji
  ];

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1"; # Hint electron apps to use wayland
  };
}
