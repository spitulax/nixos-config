{ config
, lib
, pkgs
, ...
}:
let
  cfg = config.configs.desktop;
in
{
  config = lib.mkIf (cfg.enable && cfg.displayManager) {
    services = {
      xserver.enable = true;
      displayManager = {
        inherit (config.configs.desktop) defaultSession;
        regreet = {
          enable = true;
          # TODO: global theming (gtk)
          # NOT PRETTY :(
          theme = {
            # FIXME: This theme is kinda broken in regreet
            package = pkgs.tempPkgs.stable.rose-pine-gtk-theme;
            name = "rose-pine";
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
            appearance.greeting_msg = "Welcome back to ${config.configs.hostname}!";
            widget.clock = {
              format = "%H:%M";
              timezone = config.time.timeZone;
            };
            env.XCURSOR_SIZE = "36";
          };
        };
      };
      greetd = {
        enable = true;
      };
    };

    environment.etc."greetd/regreet.png".source = "${pkgs.myArgs.vars.assetsPath}/wallpapers/nixos-catppuccin-mocha.png";

    # The login keyring did not get unlocked after login. I gave up.
    # But there's a potential fix I haven't tried yet...
    # https://github.com/NixOS/nixpkgs/issues/246197
    # https://codeberg.org/ivanbrennan/nixos-config/commit/d8a77d947838a6e9c5ef117ddf97fb68c577112a

    # services.gnome.gnome-keyring.enable = true;
    # security.pam.services = {
    #   greetd.enableGnomeKeyring = true;
    #   greetd-password.enableGnomeKeyring = true;
    #   login.enableGnomeKeyring = true;
    # };
    # services.dbus.packages = [ pkgs.gnome-keyring pkgs.gcr_4 ];
    # services.xserver.displayManager.sessionCommands = ''
    #   # eval $(gnome-keyring-daemon --start --daemonize --components=ssh,secrets)
    #   export SSH_AUTH_SOCK
    # '';
  };
}
