{ myLib }:
builtins.removeAttrs
  (myLib.genAttrsEachFileExtRec ./. "nix" (n: import ./${n}))
  [ "default" ]
