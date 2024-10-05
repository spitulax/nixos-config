{ pkgs
, myLib
, lib
}:
pkgs.symlinkJoin {
  name = "scripts";
  paths =
    map
      (x: pkgs.writeScriptBin (myLib.truncateExt "sh" x) (builtins.readFile ./${x}))
      (lib.remove "default.nix" (myLib.listFilesExt ./. "sh"));
}
