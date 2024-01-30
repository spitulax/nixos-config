{ config
, pkgs
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
    REPOS = "$HOME/Repos";
    NOTES = "$HOME/Notes";
    THIRDPARTY = "$HOME/Thirdparty";
    SOFTWARE = "$HOME/Software";
    TEMPDIR = "$HOME/.temp";
    CONFIG = "$HOME/.nixos-config";
    GPG_TTY = "$(tty)";
  };
  xdg = {
    enable = true;
    cacheHome = "${home}/.cache";
    configHome = "${home}/.config";
    dataHome = "${home}/.local/share";
    stateHome = "${home}/.local/state";
    userDirs = {
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
      };
    };
  };
}
