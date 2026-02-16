{ config
, lib
, pkgs
, ...
}:
let
  cfg = config.configs.desktop.sway;

  script = pkgs.writeShellScriptBin "swaypaper" ''
    WALLPAPERRC="$XDG_DATA_HOME/wallpaperrc"

    usage () {
        echo "Start:                swaypaper start"
        echo "Change:               swaypaper change <wallpaper> [mode]"
        echo "Help:                 swaypaper --help"
    }

    start () {
        local wallpaper
        local mode
        IFS=':' read wallpaper mode < "$WALLPAPERRC"
        swaymsg output '*' bg "$wallpaper" "$mode"
    }

    change () {
        local wallpaper="$(realpath "$1")"
        local mode="''${2:-fit}"
        echo -n "$wallpaper:$mode" > "$WALLPAPERRC"
        start
        echo "Changed current wallpaper to $1 with mode $mode"
    }

    case $# in
        3)
            case "$1" in
                "change")
                    change "$2" "$3"
                    ;;
                *)
                    usage
                    exit 1
            esac
            ;;
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
                "start")
                    start
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
in
{
  config = lib.mkIf cfg.enable {
    home.packages = [
      script
    ];

    systemd.user.services.swaypaper = {
      Unit = {
        Description = "Display wallpaper on Sway";
        After = "sway-session.target";
      };
      Service = {
        Type = "oneshot";
        ExecStart = "${lib.meta.getExe script} start";
        Environment = [
          "PATH=${lib.makeBinPath [ pkgs.sway ]}"
        ];
      };
      # Install.WantedBy = [ "sway-session.target" ];
    };
  };
}
