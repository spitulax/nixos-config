{ symlinkJoin
, writeScriptBin
, myLib
}:
symlinkJoin {
  name = "scripts";
  paths =
    map
      (x: writeScriptBin (myLib.truncateExt "sh" x) (builtins.readFile ./scripts/${x}))
      (myLib.listFilesExt ./scripts "sh");
}
