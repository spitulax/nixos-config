{ config
, lib
, myLib
, ...
}:
let
  inherit (lib)
    mkEnableOption
    mkIf
    mkOption
    types
    mapAttrs
    mapAttrs'
    nameValuePair
    literalExpression
    ;
  inherit (myLib)
    stripAttrs
    ;

  cfg = config.configs.env;
  home = config.home.homeDirectory;

  defaultProgramOptions = {
    editor = "EDITOR";
    terminal = "TERMINAL";
    browser = "BROWSER";
    fileManager = "FILE_MANAGER";
  };
in
{
  options.configs.env = {
    enable = mkEnableOption "environment variables" // { default = true; };

    addExtraDirs = mkEnableOption "extra XDG directories for daily drive systems";

    extraVariables = mkOption {
      type = types.attrsOf types.str;
      default = { };
      example = literalExpression ''
        {
          FOO = "BAR";
        }
      '';
      description = "Extra environment variables.";
    };

    extraPath = mkOption {
      type = types.listOf types.str;
      default = [ ];
      description = "Extra directories to add to PATH variable.";
    };

    extraXdgDirs = mkOption {
      type = types.attrsOf types.str;
      default = { };
      example = literalExpression ''
        {
          HOMEWORKS_DIR = "''${config.xdg.userDirs.documents}/Homeworks";
        }
      '';
      description = "Extra XDG directories.";
    };

    autoCreateXdgDirs = mkEnableOption "" // {
      default = true;
      description = "Whether to create missing XDG directories.";
    };

    defaultPrograms =
      mapAttrs
        (_: v: mkOption {
          type = types.nullOr types.str;
          default = null;
          description = "The ${v} variable.";
        })
        defaultProgramOptions;
  };

  config = mkIf cfg.enable {
    home.sessionPath = [
      "${home}/.local/bin"
      "${home}/.cargo/bin"
    ] ++ cfg.extraPath;

    home.sessionVariables = {
      GPG_TTY = "$(tty)";
      WINEPREFIX = "${config.xdg.dataHome}/wine";
      NIXOS_PROFILE = "/nix/var/nix/profiles/system";
      HM_PROFILE = "${config.xdg.stateHome}/nix/profiles/home-manager";
      USER_PROFILE = "${config.xdg.stateHome}/nix/profiles/profile"; # aka ~/.nix-profile
    }
    // mapAttrs'
      (k: v:
        nameValuePair
          defaultProgramOptions.${k}
          v
      )
      (stripAttrs cfg.defaultPrograms)
    // cfg.extraVariables;

    xdg = {
      enable = true;
      cacheHome = "${home}/.cache";
      configHome = "${home}/.config";
      dataHome = "${home}/.local/share";
      stateHome = "${home}/.local/state";
      userDirs = rec {
        enable = true;
        createDirectories = cfg.autoCreateXdgDirs;
        desktop = null;
        documents = "${home}/Documents";
        download = "${home}/Downloads";
        music = "${home}/Music";
        pictures = "${home}/Pictures";
        publicShare = null;
        templates = null;
        videos = "${home}/Videos";
        extraConfig = {
          TEMP_DIR = "${home}/.temp";
          THIRDPARTY_DIR = "${home}/Thirdparty";
        }
        // lib.optionalAttrs cfg.addExtraDirs {
          BACKUPS_DIR = "${home}/Backups";
          GAMES_DIR = "${home}/Games";
          IMPORTANT_DIR = "${home}/Important";
          NOTES_DIR = "${home}/Notes";
          REPOS_DIR = "${home}/Repos";
          SYNC_DIR = "${home}/Sync";
          SCREENSHOT_DIR = "${pictures}/Screenshots";
          CAPTURE_DIR = "${videos}/Captures";
          FLAKE_DIR = "${home}/Config";
        }
        // cfg.extraXdgDirs;
      };
    };
  };
}
