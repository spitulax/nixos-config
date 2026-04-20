{ config
, lib
, ...
}:
let
  cfg = config.configs.gaming.emulators.retroarch;
in
{
  options.configs.gaming.emulators.retroarch.enable = lib.mkEnableOption "RetroArch";

  config = lib.mkIf cfg.enable {
    programs.retroarch = {
      enable = true;
      cores = {
        dolphin.enable = true;
        mupen64plus.enable = true;
        citra.enable = true;
      };
    };

    xdg.desktopEntries.retroarch = {
      name = "Retroarch (Gamemode)";
      exec = "gamemoderun retroarch %F";
      icon = "com.libretro.RetroArch";
      categories = [ "Game" "Emulator" ];
      type = "Application";
    };
  };
}
