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
        setSessionVariables = true;
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
          TEMP = "${home}/.temp";
          THIRDPARTY = "${home}/Thirdparty";
        }
        // lib.optionalAttrs cfg.addExtraDirs {
          BACKUPS = "${home}/Backups";
          GAMES = "${home}/Games";
          IMPORTANT = "${home}/Important";
          NOTES = "${home}/Notes";
          REPOS = "${home}/Repos";
          SYNC = "${home}/Sync";
          SCREENSHOT = "${pictures}/Screenshots";
          CAPTURE = "${videos}/Captures";
          FLAKE = "${home}/Config";
        }
        // cfg.extraXdgDirs;
      };
    };
  };
}
