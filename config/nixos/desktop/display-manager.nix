{ config
, lib
, pkgs
, ...
}: {
  config = lib.mkIf config.configs.desktop.enable {
    services = {
      xserver.enable = true;
      displayManager = {
        inherit (config.configs.desktop) defaultSession;
      };
      greetd = {
        enable = true;
      };
    };

    programs.regreet = {
      enable = true;
      # TODO: global theming (gtk)
      # NOT PRETTY :(
      theme = {
        package = pkgs.fluent-gtk-theme.override {
          tweaks = [ "round" ];
          colorVariants = [ "dark" ];
        };
        name = "Fluent-round-Dark";
      };
      iconTheme = {
        package = pkgs.papirus-icon-theme;
        name = "Papirus-Dark";
      };
      font = {
        name = "sans-serif";
        size = 10;
      };
      cursorTheme = {
        name = "WhiteSur-cursors";
        package = pkgs.whitesur-cursors;
      };
      settings = {
        background.path = "/etc/greetd/regreet.png";
        appearance.greeting_msg = "Welcome to ${config.configs.hostname}!";
        widget.clock = {
          format = "%H:%M";
          timezone = config.time.timeZone;
        };
      };
    };

    environment.etc."greetd/regreet.png".source = "${pkgs.myArgs.vars.assetsPath}/wallpapers/nixos-catppuccin-mocha.png";

    # FIXME: Fix "the login keyring did not get unlocked when you logged into your computer" (NOT WORKING)
    # https://github.com/JohnRTitor/nix-conf/commit/53bc83aef18849976d5a42cc727d38dd0e38c5b0
    security.pam.services = {
      greetd.enableGnomeKeyring = true;
      greetd-password.enableGnomeKeyring = true;
      login.enableGnomeKeyring = true;
    };
    services = {
      dbus.packages = [ pkgs.gnome-keyring pkgs.gcr ];
      xserver.displayManager.sessionCommands = ''
        eval $(gnome-keyring-daemon --start --daemonize --components=ssh,secrets)
        export SSH_AUTH_SOCK
      '';
    };
  };
}
