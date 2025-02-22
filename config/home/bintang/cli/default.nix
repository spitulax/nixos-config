{ config
, lib
, pkgs
, ...
}:
let
  cfg = config.configs.cli;
in
{
  imports = [
    ./fish
    ./aliases.nix
    ./ani-cli.nix
    ./bat.nix
    ./btop.nix
    ./cava.nix
    ./downloader.nix
    ./eza.nix
    ./git.nix
    ./openssh.nix
    ./tmux.nix
    ./trash.nix
  ];

  options.configs.cli = {
    commonPackages = lib.mkEnableOption "common CLI packages" // {
      default = true;
    };
  };

  config = lib.mkIf cfg.commonPackages {
    home.packages = with pkgs; [
      fastfetch
      glow # Markdown reader
      ripgrep # faster grep
      imagemagick # image manipulation
      tokei # code line counter
      fontpreview
      dust # disk usage visualizer
      ncdu # disk usage file browser
      chafa # image visualizer
      ffmpeg
      hexyl # hex editor
      jq # JSON parser
      ouch # archiving tool
      poppler_utils # PDF
      mypkgs.lexurgy
      mypkgs.crt
      mypkgs.pasteme
      custom.scripts
    ];

    xdg.configFile = {
      "glow".source = ./configs/glow;
      "fastfetch".source = ./configs/fastfetch;
    };
  };
}
