{ config
, lib
, pkgs
, ...
}:
let
  cfg = config.configs.gaming.emulators.ryujinx;
in
{
  options.configs.gaming.emulators.ryujinx.enable = lib.mkEnableOption "Ryujinx (Nintendo Switch)";

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      ryubing
    ];

    xdg.desktopEntries.ryujinx = {
      name = "Ryujinx (Gamemode)";
      exec = "gamemoderun Ryujinx.sh %f";
      icon = "Ryujinx";
      categories = [ "Game" "Emulator" ];
      type = "Application";
    };
  };
}
