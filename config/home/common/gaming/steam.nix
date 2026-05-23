{ config
, lib
, pkgs
, ...
}:
let
  cfg = config.configs.gaming;

  steamos-session-select = pkgs.writeShellScriptBin "steamos-session-select" ''
    steam -shutdown
  '';
in
{
  options.configs.gaming.steam.enable = lib.mkEnableOption "Steam";

  config = lib.mkIf cfg.steam.enable {
    home.packages = [
      steamos-session-select
    ];

    xdg.desktopEntries = {
      steam-deck-mode = {
        name = "Steam (Deck Mode)";
        comment = "Launch Steam in Steam Deck mode";
        exec = "gamescope -e -f -w 1600 -h 900 -- steam -steamdeck -steamos3";
        icon = "steam";
        categories = [ "Network" "FileTransfer" "Game" ];
        type = "Application";
        terminal = false;
      };
    };
  };
}
