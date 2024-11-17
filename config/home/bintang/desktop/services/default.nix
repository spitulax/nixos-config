{ myLib
, pkgs
, lib
} @ inputs:
builtins.removeAttrs
  (myLib.genAttrsEachFileExtRec ./. "nix" (n: import ./${n} inputs))
  [ "default" ]
