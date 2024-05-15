{ pkgs
, lib
, myLib
}: {
  # Simple scripts
  scripts = pkgs.symlinkJoin {
    name = "scripts";
    paths =
      builtins.attrValues
        (myLib.genAttrsEachDirs ./. (n: pkgs.callPackage ./${n} { }));
  };
}
