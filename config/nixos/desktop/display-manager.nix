{ config
, lib
, pkgs
, outputs
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
      # Matches config/home/bintang/desktop/gtk.nix
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

    environment.etc."greetd/regreet.png".source = "${outputs.vars.assetsPath}/wallpapers/nixos-catppuccin-mocha.png";

    # https://discourse.nixos.org/t/login-keyring-did-not-get-unlocked-hyprland/40869/10
    # It still doesn't work
    security.pam.services.gdm-password.enableGnomeKeyring = true;
    environment.variables.XDG_RUNTIME_DIR = "/run/user/$UID";
  };
}
