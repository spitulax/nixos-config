{ users
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
      art.enable = true;
      browser.brave = true;
      dolphin.enable = true;
      entries.enable = true;
      kitty.enable = true;
      mime = {
        text = "nvim.desktop";
        audio = "mpv.desktop";
        video = "mpv.desktop";
        image = "org.nomacs.ImageLounge.desktop";
        pdf = "brave-browser.desktop";
        vector = "brave-browser.desktop";
        web = "brave-browser.desktop";
        directory = "yazi.desktop";
        wordDoc = "writer.desktop";
        slideshowDoc = "impress.desktop";
        spreadsheetDoc = "calc.desktop";
      };
      media = {
        mpv = true;
        nomacs = true;
      };
      obs.enable = true;
      office = {
        enable = true;
        installSpellingDicts = true;
      };
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
      debugger = true;
      # go = true;
      # godot = true;
      javascript = true;
      lua = true;
      nix = true;
      odin = true;
      python = true;
      # rust = true;
      tools = true;
    };

    gaming = {
      games = {
        osu = true;
      };
      lutris.enable = true;
      misc.enable = true;
    };

    services = {
      syncthing.enable = true;
    };

    gpg.enable = true;
    sops.enable = true;
    neovim.enable = true;
    yazi.enable = true;
    keymapper.enable = true;
    wine.enable = true;
    nix.useAccessToken = true;
  };
}
