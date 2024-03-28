{ pkgs
, ...
}: with pkgs; {
  # Simple scripts
  custom.scripts = {
    reminder = callPackage ./reminder { };
    wallpaper = callPackage ./wallpaper { };
    screenshot = callPackage ./screenshot { };
  };

  lexurgy = callPackage ./lexurgy { };
}
