{ users
, pkgs
, ...
}: {
  imports = [
    users.bintang.homeManagerModule
  ];

  configs = {
    env = {
      enable = true;
      addExtraDirs = true;
      defaultPrograms = {
        editor = "nvim";
        terminal = "kitty";
        browser = "brave";
        tuiFileManager = "yazi";
        guiFileManager = "dolphin";
      };
    };

    apps = {
      anki.enable = true;
      art.enable = true;
      browser.brave = true;
      dolphin.enable = true;
      entries.enable = true;
      kitty.enable = true;
      mpv.enable = true;
      mime = {
        text = "nvim.desktop";
        audio = "mpv.desktop";
        video = "mpv.desktop";
        image = {
          entry = "org.nomacs.ImageLounge.desktop";
          packages = [ pkgs.nomacs ];
        };
        pdf = {
          entry = "io.github.JakubMelka.Pdf4qt.Pdf4QtViewer.desktop";
          packages = [ pkgs.pdf4qt ];
        };
        vector = "brave-browser.desktop";
        web = "brave-browser.desktop";
        directory = "org.kde.dolphin.desktop";
        wordDoc = "writer.desktop";
        slideshowDoc = "impress.desktop";
        spreadsheetDoc = "calc.desktop";
      };
      obs.enable = true;
      office = {
        enable = true;
        installSpellingDicts = true;
      };
      obsidian.enable = true;
    };

    cli = {
      aliases.enable.fish = true;
      ani-cli.enable = true;
      bat = {
        enable = true;
        alias.fish = true;
      };
      eza.alias.fish = true;
      cava.enable = true;
      downloader.enable = true;
      fish = {
        atuin = true;
      };
      git = {
        gh = true;
      };
    };

    desktop = {
      enable = true;
      hyprland = {
        enable = true;
        monitor = "eDP-1,1920x1080@60,0x0,1";
      };
      cliphist.enable = true;
      gammastep.enable = true;
    };

    dev = {
      cpp = true;
      # go = true;
      # godot = true;
      javascript = true;
      lua = true;
      nix = true;
      odin = true;
      python = true;
      rust = true;
      debugger = true;
      benchmark = true;
      misc = true;
    };

    gaming = {
      games = {
        osu = true;
      };
      lutris.enable = false;
      misc.enable = true;
    };

    services = {
      syncthing.enable = true;
    };

    gpg.enable = true;
    sops.enable = true;
    neovim.enable = true;
    yazi.enable = false;
    keymapper.enable = true;
    wine.enable = true;
    nix.useAccessToken = true;
  };
}
