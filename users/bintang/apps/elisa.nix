{ config
, pkgs
, ...
}: {
  home.packages = [ pkgs.libsForQt5.elisa ];
  home.file.".config/elisarc".text = ''
    [ElisaFileIndexer]
    RootPath[$e]=$HOME/Music

    [UiSettings]
    ColorScheme=

    [Views]
    InitialView=AllAlbums
  '';
}
