{ config
, lib
, pkgs
, ...
}: {
  config = lib.mkIf config.configs.desktop.enable {
    home.packages = with pkgs; [
      kde.qt6ct
      kde.qtstyleplugin-kvantum
      papirus-icon-theme
    ];

    qt = {
      enable = true;
      platformTheme.name = "qtct";
      style.name = "kvantum";
    };
  };
}
