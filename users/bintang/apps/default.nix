{ pkgs
, myLib
, ...
}: myLib.importIn ./. // {

  home.packages = with pkgs; [
    nomacs
  ];
}
