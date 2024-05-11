{ pkgs
, lib
}: {
  # Simple scripts
  scripts = pkgs.symlinkJoin {
    name = "scripts";
    paths =
      builtins.attrValues
        (lib.genAttrsEachDirs ./. (n: pkgs.callPackage ./${n} { }));
  };
}
