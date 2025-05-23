{ myLib }:
myLib.genAttrsEachFileExtManual ./. "nix"
  [
    "keymapper"
    "webApps"
  ]
  (p: _: import p)
