{ config
, pkgs
, lib
, ...
}:
with lib;
let
  cfg = config.programs.brave.webApps;
in
{
  options.programs.brave.webApps = {
    enable = mkEnableOption "web apps";

    apps = mkOption {
      type = with types; attrsOf (submodule {
        options = {
          id = mkOption {
            type = strMatching "[a-zA-Z]{32}";
            description = "The extension ID of the app. You can get it from chrome://app-service-internals";
          };

          actions = mkOption {
            type = attrsOf str;
            default = { };
            description = "The set of actions made available to application launchers and the URL to open.";
          };
        };
      });
      default = { };
      example = literalExpression ''
        {
          GitHub.id = "mjoklplbddabcmpepnokjaffbmgbkkgg";
          YouTube = {
            id = "agimnkijcaahngcdmfeangaknmldooml";
            actions = {
              Subscriptions = "https://www.youtube.com/feed/subscriptions?feature=app_shortcuts";
            };
          };
        }
      '';
      description = "The list of apps.";
    };

    package = mkOption {
      type = types.package;
      default = pkgs.brave;
      description = "The brave package";
      example = "config.programs.brave.package";
    };

    commandLineArgs = mkOption {
      type = types.listOf types.str;
      default = [ ];
      description = "The command line arguments to pass to the browser";
      example = "config.programs.brave.commandLineArgs";
    };
  };

  config = mkIf cfg.enable {
    xdg.desktopEntries =
      mapAttrs'
        (name: app: {
          name = "brave-${replaceStrings [ " " ] [ "-" ] name}";
          value = rec {
            inherit name;
            exec = "${getExe cfg.package} --app-id=${app.id} " + (lib.strings.concatStringsSep " " cfg.commandLineArgs);
            type = "Application";
            icon = "brave-${app.id}-Default";
            startupNotify = true;
            terminal = false;
            settings = {
              StartupWMClass = "crx_${app.id}";
            };
            actions =
              mapAttrs
                (name: url: {
                  inherit name;
                  exec = "${exec} \"--app-launch-url-for-shortcuts-menu-item=${url}\"";
                })
                app.actions;
          };
        })
        cfg.apps;
  };
}
