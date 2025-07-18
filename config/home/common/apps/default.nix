{ config
, pkgs
, myLib
, ...
}:
let
  inherit (myLib.hmHelper)
    mkPkgsOptions
    mkPkgsConfig
    ;

  cfg = config.configs.apps;

  modules = with pkgs; {
    anki = {
      desc = "Anki";
      pkgs = [ anki ];
    };

    art = {
      desc = "art programs";
      pkgs = [
        krita
        inkscape
      ];
    };

    bottles = {
      desc = "Bottles";
      pkgs = [ bottles ];
    };

    dolphin = {
      desc = "Dolphin file manager";
      pkgs = with kde; [
        dolphin
        ffmpegthumbs
        kio-extras
      ];
    };

    electrum = {
      desc = "Electrum Bitcoin wallet";
      pkgs = [ electrum ];
    };

    gplates = {
      desc = "GPlates";
      pkgs = [ gplates ];
    };

    kooha = {
      desc = "Kooha screen recorder";
      pkgs = [ kooha ];
    };

    obsidian = {
      desc = "Obsidian";
      pkgs = [ obsidian ];
    };

    qbittorrent = {
      desc = "qBittorrent";
      pkgs = [ qbittorrent ];
    };

    qgis = {
      desc = "QGIS";
      pkgs = [ qgis ];
    };
  };
in
{
  imports = [
    ./browser.nix
    ./distrobox.nix
    ./entries.nix
    ./kitty.nix
    ./mime.nix
    ./mpv.nix
    ./obs.nix
    ./office.nix
    ./spotify.nix
    ./zathura.nix
  ];

  options.configs.apps = mkPkgsOptions { inherit modules; };

  config = {
    home.packages = mkPkgsConfig { inherit modules cfg; };
  };
}
