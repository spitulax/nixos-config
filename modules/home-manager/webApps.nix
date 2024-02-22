{ config
, pkgs
, lib
, ...
}:
with lib;
let
  cfg = config.programs.chromium.webApps;
in
{
  options.programs.chromium.webApps = {
    enable = mkEnableOption "web apps";

    defaultBrowserName = mkOption {
      type = types.str;
      example = literalExpression "brave";
      description = "The default browser's name for namespacing";
    };

    defaultBrowserExec = mkOption {
      type = types.path;
      example = literalExpression "\${pkgs.brave}/opt/brave.com/brave/brave-browser";
      description = "The default browser executable for running the apps.";
    };

    defaultProfile = mkOption {
      type = types.str;
      default = literalExpression "Default";
      description = "The default profile to use when opening the apps.";
    };

    apps = mkOption {
      type = with types; listOf (submodule {
        options = {
          name = mkOption {
            type = str;
            description = "The display name of the app.";
          };

          id = mkOption {
            type = strMatching "[a-zA-Z]{32}";
            description = "The extension ID of the app. You can get it from chrome://app-service-internals/";
          };

          actions = mkOption {
            type = attrsOf (submodule ({ name, ... }: {
              options = {
                name = mkOption {
                  type = str;
                  description = "The name of the action";
                };
                launchUrl = mkOption {
                  type = nullOr str;
                  default = null;
                  description = "Url to open for this action.";
                };
              };
            }));
            default = { };
            description = "The set of actions made available to application launchers.";
          };
        };
      });
      default = [ ];
      example = literalExpression ''
        [
          {
            name = "GitHub";
            id = "mjoklplbddabcmpepnokjaffbmgbkkgg";
          }

          {
            name = "YouTube";
            id = "agimnkijcaahngcdmfeangaknmldooml";
            actions = {
              "Subscriptions" = {
                launchUrl = [ "https://www.youtube.com/feed/subscriptions?feature=app_shortcuts" ];
              };
            };
          }
        ];
      '';
      description = "The extension ID of the app.";
    };
  };

  config = mkIf cfg.enable {
    xdg.desktopEntries = builtins.listToAttrs (builtins.map (app:
      let
        exec = "${cfg.defaultBrowserExec} --profile-directory=${cfg.defaultProfile} --app-id=${app.id}";
      in
      {
        name = "${cfg.defaultBrowserName}-${app.id}-${cfg.defaultProfile}";
        value = {
          inherit exec;
          type = "Application";
          icon = "${cfg.defaultBrowserName}-${app.id}-${cfg.defaultProfile}";
          name = "${app.name}";
          startupNotify = true;
          terminal = false;
          settings = {
            StartupWMClass = "crx_${app.id}";
          };
          actions = builtins.mapAttrs (name: action: {
            name = name;
            exec = "${exec} \"--app-launch-url-for-shortcuts-menu-item=${action.launchUrl}\"";
          }) app.actions;
        };
      })
    cfg.apps);
  };
}
