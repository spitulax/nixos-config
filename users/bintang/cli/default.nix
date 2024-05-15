{ pkgs
, myLib
, ...
}: myLib.importIn ./. // {

  home.packages = with pkgs; [
    eza
    ripgrep
    imagemagick
    cloc
    fontpreview
    trash-cli
    bat
    dust
    ncdu
    chafa
    yt-dlp
    ffmpeg
    mypkgs.lexurgy
  ];
}
