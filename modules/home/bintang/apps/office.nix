{ pkgs
, ...
}: {
  home.packages = with pkgs; [
    libreoffice-fresh
    hunspell
    mypkgs.hunspell-id
  ] ++ (with pkgs.hunspellDicts; [
    en-gb-ize
    en-us
  ]);
}
