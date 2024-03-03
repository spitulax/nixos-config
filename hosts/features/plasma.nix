{ config
, pkgs
, ...
}: {
  services.xserver.desktopManager.plasma5.enable = true;
  environment.systemPackages = with pkgs; [
    libsForQt5.qtstyleplugin-kvantum
    whitesur-kde
  ];
  services.xserver.displayManager.sddm.theme = "WhiteSur";
}
