{ users
, pkgs
, config
, ...
}:
let
  cfg = config.configs;
in
{
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
        fileManager = "dolphin";
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
          entry = "org.kde.gwenview.desktop";
          packages = [ pkgs.kde.gwenview ];
        };
        pdf = {
          entry = "org.kde.okular.desktop";
          packages = [ pkgs.kde.okular ];
        };
        vector = "brave-browser.desktop";
        web = "brave-browser.desktop";
        directory = "org.kde.dolphin.desktop";
      };
      obs.enable = false;
      office = {
        enable = true;
        installSpellingDicts = true;
        configureMime = true;
      };
      obsidian.enable = true;
      distrobox.enable = false;
      gplates.enable = true;
      qgis.enable = true;
    };

    cli = {
      aliases.enable.fish = true;
      shellIntegrations = [ "Fish" ];
      ani-cli.enable = true;
      eza.alias.fish = true;
      cava.enable = true;
      downloader.enable = false;
      fish = {
        atuin = true;
      };
      git = {
        gh = true;
      };
      fastfetch.enable = true;
      imagemagick.enable = true;
      fontpreview.enable = true;
      diskVisualizers.enable = true;
      chafa.enable = true;
      ffmpeg.enable = true;
      hexyl.enable = true;
      jq.enable = true;
      poppler-utils.enable = true;
      lexurgy.enable = true;
      pasteme.enable = true;
    };

    desktop = {
      enable = true;
      hyprland = {
        enable = true;
        monitor = "eDP-1,1920x1080@60,0x0,1";
      };
      warn-low-battery.enable = true;
    };

    dev = {
      cpp.enable = true;
      python.enable = true;
      lua.enable = true;
      nix.enable = true;
      debugger.enable = true;
      benchmark.enable = true;
      make.enable = true;
      text.enable = true;
      misc.enable = true;
      php.enable = true;
      javascript.enable = true;
    };

    gaming = {
      games = {
        osu.enable = false;
        mcpe.enable = false;
        minecraft.enable = true;
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
    keymapper.enable = false;
    # Enable nix-gaming cache if you want to use this.
    wine.enable = false;
    fcitx5.enable = true;
    nix.useAccessToken = cfg.sops.enable;
  };
}
