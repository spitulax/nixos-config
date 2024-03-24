{ pkgs
, ...
}: with pkgs; {
  # Simple scripts
  custom.scripts = {
    reminder = callPackage ./reminder { };
    wallpaper = callPackage ./wallpaper { };
  };

  lexurgy = callPackage ./lexurgy { inherit pkgs; };
}
