{ config
, pkgs
, myLib
, ...
}:
let
  inherit (myLib.hmHelper)
    packages
    ;

  cfg = config.configs.cli;

  imports = [
    ./fish
    ./aliases.nix
    # ./bat.nix
    ./btop.nix
    ./cava.nix
    ./downloader.nix
    ./eza.nix
    ./fastfetch.nix
    ./git.nix
    ./glow.nix
    ./newsboat.nix
    ./openssh.nix
    ./shell.nix
    ./tmux.nix
    ./trash.nix
  ];

  modules = with pkgs; {
    ani-cli = {
      desc = "ani-cli";
      pkgs = [ ani-cli ];
    };

    ripgrep = {
      desc = "ripgrep";
      default = true;
      pkgs = [ ripgrep ];
    };

    imagemagick = {
      desc = "ImageMagick";
      pkgs = [ imagemagick ];
    };

    fontpreview = {
      desc = "fontpreview";
      pkgs = [ fontpreview ];
    };

    diskVisualizers = {
      desc = "disk visualizers";
      pkgs = [
        dust
        ncdu
      ];
    };

    chafa = {
      desc = "Chafa terminal image displayer";
      pkgs = [ chafa ];
    };

    ffmpeg = {
      desc = "FFmpeg";
      pkgs = [ ffmpeg ];
    };

    hexyl = {
      desc = "Hexyl hex editor";
      pkgs = [ hexyl ];
    };

    jq = {
      desc = "jq JSON parser";
      pkgs = [
        jq
        jqp
      ];
    };

    ouch = {
      desc = "ouch";
      default = true;
      pkgs = [ ouch ];
    };

    poppler-utils = {
      desc = "Poppler PDF rendering library";
      pkgs = [ poppler-utils ];
    };

    lexurgy = {
      desc = "Lexurgy";
      pkgs = [ mypkgs.lexurgy ];
    };

    pasteme = {
      desc = "Pasteme";
      pkgs = [ mypkgs.pasteme ];
    };

    scripts = {
      desc = "custom scripts";
      default = true;
      pkgs = [ custom.scripts ];
    };
  };
in
{
  inherit imports;

  options.configs.cli = packages.mkOptions { inherit modules; };

  config = {
    home.packages = packages.mkConfig { inherit modules cfg; };
  };
}
