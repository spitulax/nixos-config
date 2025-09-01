{ config
, pkgs
, myLib
, ...
}:
let
  inherit (myLib.hmHelper)
    packages
    ;

  cfg = config.configs.apps;

  modules = with pkgs; {
    # TODO: `programs.anki`
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
    ./dolphin.nix
    ./entries.nix
    ./kitty.nix
    ./mime.nix
    ./mpv.nix
    ./obs.nix
    ./office.nix
    # ./spotify.nix
    # ./zathura.nix
  ];

  options.configs.apps = packages.mkOptions { inherit modules; };

  config = {
    home.packages = packages.mkConfig { inherit modules cfg; };
  };
}
