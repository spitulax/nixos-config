{ pkgs
, ...
}: with pkgs; {
  # Simple scripts
  custom.scripts = {
    # Simple (scuffed) reminder with notify-send
    reminder = callPackage ./reminder { };
    # Control wallpaper with swww
    wallpaper = callPackage ./wallpaper { };
    # Wrapper script to grim (wayland screenshot)
    screenshot = callPackage ./screenshot { };
    # A hacky (stupid) way to update lazy.nvim plugins
    lazyup = callPackage ./lazyup { };
    # Control monitor brightness
    brightness = callPackage ./brightness { };
    # Control volume
    volume = callPackage ./volume { };
  };

  lexurgy = callPackage ./lexurgy { };
}
