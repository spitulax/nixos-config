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
    REPOS = "$HOME/Repos";
    NOTES = "$HOME/Notes";
    THIRDPARTY = "$HOME/Thirdparty";
    SOFTWARE = "$HOME/Software";
    TEMPDIR = "$HOME/.temp";
    CONFIG = "$HOME/Config";
    GAMES = "$HOME/Games";
    FLAKE = CONFIG;
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
    mimeApps = {
      enable = true;
      defaultApplications = {
        "text/plain" = "nvim.desktop";
        "inode/directory" = "thunar.desktop";
        "x-scheme-handler/http" = "brave-browser.desktop";
        "x-scheme-handler/https" = "brave-browser.desktop";
      };
      associations.added = {
        "image/png" = "org.kde.gwenview.desktop";
        "image/jpeg" = "org.kde.gwenview.desktop";
        "video/ogg" = "mpv.desktop";
        "video/x-msvideo" = "mpv.desktop";
        "audio/mpeg" = "mpv.desktop";
        "video/quicktime" = "mpv.desktop";
        "video/webm" = "mpv.desktop";
        "video/x-flv" = "mpv.desktop";
        "video/mp4" = "mpv.desktop";
        "audio/x-flac" = "mpv.desktop";
        "audio/mp4" = "mpv.desktop";
      };
    };
  };
}
