{ myLib }:
builtins.removeAttrs
  (myLib.genAttrsEachFilesExtRec ./. "nix" (n: import ./${n}))
  [ "default" ]
