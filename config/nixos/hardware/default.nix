{ myLib
, ...
}: {
  imports = myLib.importIn ./.;
}