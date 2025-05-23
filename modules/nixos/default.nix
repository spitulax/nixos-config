{ myLib }:
myLib.genAttrsEachFileManual ./. "nix"
  [ ]
  (p: _: import p)
