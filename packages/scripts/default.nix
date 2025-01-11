{ symlinkJoin
, writeScriptBin
, myLib
, lib
}:
symlinkJoin {
  name = "scripts";
  paths =
    map
      (x: writeScriptBin (myLib.truncateExt "sh" x) (builtins.readFile ./${x}))
      (lib.remove "default.nix" (myLib.listFilesExt ./. "sh"));
}
