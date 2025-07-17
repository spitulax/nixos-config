{ myLib }:
myLib.genAttrsEachFileExtManual ./. "nix"
  [ ]
  (p: _: import p)
