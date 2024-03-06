{ config
, pkgs
, ...
}: {
  services.xserver.desktopManager.plasma5.enable = true;
  environment.systemPackages = with pkgs; [
    libsForQt5.qtstyleplugin-kvantum
    whitesur-kde
  ];
  environment.plasma5.excludePackages = with pkgs.libsForQt5; [
    elisa
    ark
    # spectacle # TODO: config flameshot
    plasma-systemmonitor
    gwenview
    konsole
    kwallet
  ];
  services.xserver.displayManager.sddm.theme = "WhiteSur";
}
