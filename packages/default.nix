{ pkgs
, ...
}: with pkgs; {
  # Simple scripts
  scripts = symlinkJoin {
    name = "scripts";
    paths = [
      # Simple (scuffed) reminder with notify-send
      (callPackage ./reminder { })
      # Control wallpaper with swww
      (callPackage ./wallpaper { })
      # Wrapper script to grim (wayland screenshot)
      (callPackage ./screenshot { })
      # A hacky (stupid) way to update/install lazy.nvim plugins
      (callPackage ./lazyup { })
      # Control monitor brightness
      (callPackage ./brightness { })
      # Control volume
      (callPackage ./volume { })
      # Find files up the directory tree
      (callPackage ./upfind { })
      # Wrapper to `nix store gc` that also deletes old profiles
      (callPackage ./clean { })
      # Tmux that search for .tmux socket
      (callPackage ./tmuxs { })
    ];
  };
}
