{ config
, lib
, pkgs
, ...
}:
let
  cfg = config.configs.gaming.steam;

  steamos-session-select = pkgs.writeShellScriptBin "steamos-session-select" ''
    steam -shutdown
  '';
in
{
  imports = [
    ./steam-presence.nix
  ];

  options.configs.gaming.steam = {
    enable = lib.mkEnableOption "Steam";
    bigPicture = lib.mkEnableOption "Steam Big Picture shortcut" // {
      default = cfg.enable;
    };
  };

  config = lib.mkIf cfg.bigPicture {
    home.packages = [
      steamos-session-select
    ];

    xdg.desktopEntries = {
      steam-deck-mode = {
        name = "Steam (Big Picture)";
        comment = "Launch Steam in big picture mode";
        exec = "gamescope -e -f -w 1600 -h 900 -- steam -gamepadui -steamos3";
        icon = "steam";
        categories = [ "Network" "FileTransfer" "Game" ];
        type = "Application";
        terminal = false;
      };
    };
  };
}
