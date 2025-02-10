{ config
, lib
, pkgs
, ...
}: {
  config = lib.mkIf config.configs.desktop.enable {
    home.packages = with pkgs; [
      kde.qt5ct
      kde.qtstyleplugin-kvantum
    ];

    qt = {
      enable = true;
      platformTheme.name = "qtct";
      style.name = "kvantum";
    };
  };
}
