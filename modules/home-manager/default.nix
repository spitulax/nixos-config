{ myLib }:
builtins.removeAttrs
  (myLib.genAttrsEachFilesExt ./. "nix" (n: import ./${n}))
  [ "default" ]
