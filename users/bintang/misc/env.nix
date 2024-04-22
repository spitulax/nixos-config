{ config
, ...
}:
let
  home = config.home.homeDirectory;
in
{
  # Environment variables
  home.sessionVariables = {
    PATH = "$HOME/.cargo/bin:$HOME/.local/bin:$PATH";
    EDITOR = "nvim";
    TERMINAL = "kitty";
    BROWSER = "brave";
    FILE_MANAGER = "dolphin";
    FLAKE = "$HOME/Config";
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
        XDG_BACKUPS_DIR = "${home}/Backups";
        XDG_GAMES_DIR = "${home}/Games";
        XDG_IMPORTANT_DIR = "${home}/Important";
        XDG_NOTES_DIR = "${home}/Notes";
        XDG_REPOS_DIR = "${home}/Repos";
        XDG_SYNC_DIR = "${home}/Sync";
        XDG_THIRDPARTY_DIR = "${home}/Thirdparty";
        XDG_TEMP_DIR = "${home}/.temp";
        XDG_SCREENSHOT_DIR = "${pictures}/Screenshots";
        XDG_CAPTURE_DIR = "${videos}/Captures";
      };
    };
  };
}
