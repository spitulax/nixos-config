{ myLib
, ...
}@inputs:
myLib.genAttrsEachFileExtManual ./. "nix"
  [
    "hyprpaper"
    "hyprswitch"
    "udiskie"
    "warn-low-battery"
    "waybar"
  ]
  (p: _: import p inputs)
