{ config
, lib
, pkgs
, ...
}:
let
  cfg = config.configs.desktop.hyprland;

  inherit (lib)
    mkIf
    ;

  script = pkgs.writeShellScriptBin "wallpaper" ''
    # TODO: maybe add alternating wallpapers

    usage () {
        echo "Change:               wallpaper change <wallpaper>"
        echo "(Re)start hyprpaper:  wallpaper restart"
        echo "Help:                 wallpaper --help"
    }

    restart () {
        systemctl --user restart hyprpaper.service
    }

    change () {
        WALLPAPER=$(realpath "$1")
        echo "$WALLPAPER" > $XDG_DATA_HOME/wallpaperrc
        # Hyprpaper
        cat > $HOME/.config/hypr/hyprpaper.conf << EOF
    preload = $WALLPAPER
    wallpaper = ,$WALLPAPER
    splash = false
    ipc = false
    EOF
        restart
        echo "Changed current wallpaper to $1"
    }

    case $# in
        2)
            case "$1" in
                "change")
                    change "$2"
                    ;;
                *)
                    usage
                    exit 1
            esac
            ;;

        1)
            case "$1" in
                "--help")
                    usage
                    ;;
                "restart")
                    restart
                    ;;
                *)
                    usage
                    exit 1
            esac
            ;;

        *)
            usage
            exit 1
    esac
  '';

  package = pkgs.hyprpaper;
in
{
  config = mkIf cfg.enable {
    home.packages = [
      package
      script
    ];

    systemd.user.services.hyprpaper = {
      Unit = {
        Description = "Hyprland wallpaper daemon";
        After = "graphical-session.target";
      };
      Service = {
        Type = "exec";
        ExecStart = "${lib.meta.getExe package}";
        Restart = "on-failure";
        Slice = "background-graphical.slice";
      };
      Install.WantedBy = [ "graphical-session.target" ];
    };
  };
}
