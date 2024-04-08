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
    # A hacky (stupid) way to update/install lazy.nvim plugins
    lazyup = callPackage ./lazyup { };
    # Control monitor brightness
    brightness = callPackage ./brightness { };
    # Control volume
    volume = callPackage ./volume { };
    # Find files up the directory tree
    upfind = callPackage ./upfind { };
    # Wrapper to `nix store gc` that also deletes old profiles
    clean = callPackage ./clean { };
    # Tmux that search for .tmux socket
    tmuxs = callPackage ./tmuxs { };
  };

  lexurgy = callPackage ./lexurgy { };
}
