{ pkgs
, ...
}: with pkgs; {
  # Simple scripts
  custom.scripts = {
    reminder = callPackage ./reminder { };
    wallpaper = callPackage ./wallpaper { };
    screenshot = callPackage ./screenshot { };
    lazyup = callPackage ./lazyup { };
  };

  lexurgy = callPackage ./lexurgy { };
}
