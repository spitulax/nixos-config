{ myLib }:
myLib.genAttrsEachFileExtManual ./. "nix"
  [
    "mysql"
  ]
  (p: _: import p)
