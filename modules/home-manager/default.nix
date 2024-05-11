{ lib }:
builtins.removeAttrs
  (lib.genAttrsEachFilesExt ./. "nix" (n: import ./${n}))
  [ "default" ]
