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
        # FIXME: No wallpaper until https://nixpkgs-tracker.ocfox.me/?pr=530302
        # background.path = "/etc/greetd/regreet.png";
        appearance.greeting_msg = "Welcome back to ${config.configs.hostname}!";
        widget.clock = {
          format = "%H:%M";
          timezone = config.time.timeZone;
        };
        env.XCURSOR_SIZE = "36";
      };
    };

    environment.etc."greetd/regreet.png".source = "${pkgs.myArgs.vars.assetsPath}/wallpapers/nixos-catppuccin-mocha.png";

    # FIXME: Fix login keyring not unlocked after logging in
    # https://www.reddit.com/r/NixOS/comments/1p6dgnu/comment/nqpxcqk
    services.gnome.gnome-keyring.enable = true;
    programs.seahorse.enable = true;
    security.pam.services = {
      greetd.enableGnomeKeyring = true;
      greetd-password.enableGnomeKeyring = true;
      login.enableGnomeKeyring = true;
    };
    services.dbus.packages = [ pkgs.gnome-keyring pkgs.gcr ];
    services.xserver.displayManager.sessionCommands = ''
      eval $(gnome-keyring-daemon --start --daemonize --components=ssh,secrets)
      export SSH_AUTH_SOCK
    '';
  };
}
