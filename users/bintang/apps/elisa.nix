{ config
, pkgs
, ...
}: {
  home.packages = [ pkgs.libsForQt5.elisa ];
  home.file.".config/elisarc".text = ''
    [ElisaFileIndexer]
    RootPath[$e]=$HOME/Music

    [PlayerSettings]
    ShowSystemTrayIcon=true
    UseFavoriteStyleRatings=true

    [UiSettings]
    ColorScheme=

    [Views]
    EmbeddedView=AllAlbums
  '';
}
