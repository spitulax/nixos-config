{ pkgs
, config
, ...
}: {
  home.packages = with pkgs; [
    libsForQt5.qt5ct
    libsForQt5.qtstyleplugin-kvantum
  ];

  qt = {
    enable = true;
    platformTheme = "qtct";
    style.name = "kvantum";
  };
}
