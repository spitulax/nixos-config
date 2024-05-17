{ pkgs
, myLib
, lib
}:
pkgs.symlinkJoin {
  name = "scripts";
  paths =
    map
      (x: pkgs.callPackage ./${x} { })
      (lib.remove "default.nix" (myLib.listFiles ./.));
}
