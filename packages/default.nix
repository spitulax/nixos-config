{ pkgs
, ...
}: {
  # Simple scripts
  custom.scripts = {
    plasma-restartshell = pkgs.callPackage ./plasma-restartshell { };
    reminder = pkgs.callPackage ./reminder { };
    wallpaper = pkgs.callPackage ./wallpaper { };
  };
}
