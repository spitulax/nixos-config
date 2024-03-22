{ config
, pkgs
, ...
}:
let
  home = config.home.homeDirectory;
in
{
  # Environment variables
  home.sessionVariables = rec {
    PATH = "$HOME/.cargo/bin:$HOME/.local/bin:$PATH";
    EDITOR = "nvim";
    TERMINAL = "kitty";
    BROWSER = "brave";
    FILE_MANAGER = "dolphin";
    FLAKE = "$HOME/Config";
    GPG_TTY = "$(tty)";
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
      desktop = "${home}/Desktop";
      documents = "${home}/Documents";
      download = "${home}/Downloads";
      music = "${home}/Music";
      pictures = "${home}/Pictures";
      publicShare = null;
      templates = null;
      videos = "${home}/Videos";
      extraConfig = {
        XDG_REPO_DIR = "${home}/Repos";
        XDG_SOFTWARE_DIR = "${home}/Software";
        XDG_THIRDPARTY_DIR = "${home}/Thirdparty";
        XDG_BACKUP_DIR = "${home}/Backups";
        XDG_TEMP_DIR = "${home}/.temp";
        XDG_GAME_DIR = "${home}/Games";
        XDG_SCREENSHOT_DIR = "${pictures}/Screenshots";
        XDG_CAPTURE_DIR = "${videos}/Captures";
      };
    };
  };
}
