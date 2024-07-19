{ config
, outputs
, ...
}: {
  imports = with outputs.homeModules.bintang;
    (with apps; [
      bottles
      browser
      dolphin
      entries
      kitty
      # kooha
      mime
      mpv
      nomacs
      obs
      zathura
    ])
    ++
    (with cli; [
      ani-cli
      bat
      btop
      cava
      default
      fish
      gh
      git
      glow
      gpg
      neofetch
      ssh
      tmux
      yazi
    ])
    ++
    (with desktop; [
      cliphist
      default
      gammastep
      hyprland
      keymapper
    ])
    ++
    (with dev; [
      cpp
      debugger
      go
      godot
      javascript
      lua
      nix
      odin
      python
      rust
      tools
    ])
    ++
    (with gaming; [
      games
      # lutris
      # misc
      wine
    ])
    ++
    (with service; [
      syncthing
      udiskie
      warn-low-battery
      warp
    ])
    ++
    [
      env
      nix
      nvim
      sops
      xcompose
    ]
    ++
    [
      ./hyprland.nix
    ];

  # User info
  home = {
    username = "bintang";
    homeDirectory = "/home/${config.home.username}";
    stateVersion = "23.11";
  };

  nixpkgs = {
    inherit (outputs.pkgsFor.x86_64-linux) config overlays;
  };

  systemd.user.startServices = "sd-switch";
  programs.home-manager.enable = true;
}
