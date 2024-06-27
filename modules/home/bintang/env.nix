{ config
, ...
}:
let
  home = config.home.homeDirectory;
in
{
  # Environment variables
  home.sessionPath = [
    "${home}/.local/bin"
  ];
  home.sessionVariables = {
    EDITOR = "nvim";
    TERMINAL = "kitty";
    BROWSER = "brave";
    FILE_MANAGER = "dolphin";
    FLAKE = "${home}/Config";
    GPG_TTY = "$(tty)";
    WINEPREFIX = "${config.xdg.dataHome}/wine";
  };
  xdg = {
    enable = true;
    cacheHome = "${home}/.cache";
    configHome = "${home}/.config";
    dataHome = "${home}/.local/share";
    stateHome = "${home}/.local/state";
    userDirs = rec {
      enable = true;
      createDirectories = true;
      desktop = null;
      documents = "${home}/Documents";
      download = "${home}/Downloads";
      music = "${home}/Music";
      pictures = "${home}/Pictures";
      publicShare = null;
      templates = null;
      videos = "${home}/Videos";
      extraConfig = {
        BACKUPS_DIR = "${home}/Backups";
        GAMES_DIR = "${home}/Games";
        IMPORTANT_DIR = "${home}/Important";
        NOTES_DIR = "${home}/Notes";
        REPOS_DIR = "${home}/Repos";
        SYNC_DIR = "${home}/Sync";
        THIRDPARTY_DIR = "${home}/Thirdparty";
        TEMP_DIR = "${home}/.temp";
        SCREENSHOT_DIR = "${pictures}/Screenshots";
        CAPTURE_DIR = "${videos}/Captures";
      };
    };
  };
}
