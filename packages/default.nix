{ pkgs
, ...
}: with pkgs; {
  # Simple scripts
  custom.scripts = {
    plasma-restartshell = callPackage ./plasma-restartshell { };
    reminder = callPackage ./reminder { };
    wallpaper = callPackage ./wallpaper { };
  };

  lexurgy = callPackage ./lexurgy { inherit pkgs; };
}
