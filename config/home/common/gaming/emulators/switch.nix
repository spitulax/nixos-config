{ config
, lib
, pkgs
, ...
}:
let
  cfg = config.configs.gaming.emulators.switch;
in
{
  options.configs.gaming.emulators.switch.enable = lib.mkEnableOption "Nintendo Switch";

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      mypkgs.eden
    ];

    xdg.desktopEntries.switch = {
      name = "Eden (Gamemode)";
      exec = "gamemoderun eden %f";
      icon = "eden";
      categories = [ "Game" "Emulator" ];
      type = "Application";
    };
  };
}
