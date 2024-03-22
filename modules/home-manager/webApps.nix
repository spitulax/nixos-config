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

    commandLineArgs = mkOption {
      type = types.listOf types.str;
      default = [ ];
      description = "The command line arguments to pass to the browser";
      example = "config.programs.brave.commandLineArgs";
    };
  };

  config = mkIf cfg.enable {
    xdg.desktopEntries = builtins.listToAttrs (builtins.map
      (app:
        let
          exec = "${pkgs.brave}/bin/brave --app-id=${app.id} " + (lib.strings.concatStringsSep " " cfg.commandLineArgs);
          name = "brave-${app.id}-Default";
        in
        {
          inherit name;
          value = {
            inherit exec;
            type = "Application";
            icon = "brave-${app.id}-Default";
            name = "${app.name}";
            startupNotify = true;
            terminal = false;
            settings = {
              StartupWMClass = "crx_${app.id}";
            };
            actions = builtins.mapAttrs
              (name: action: {
                inherit name;
                exec = "${exec} \"--app-launch-url-for-shortcuts-menu-item=${action.launchUrl}\"";
              })
              app.actions;
          };
        })
      cfg.apps);

    # Add the desktop entries to ~/.local/share/applications
    # home.file = builtins.listToAttrs (builtins.map (app:
    #   let
    #     name = "${cfg.defaultBrowserName}-${app.id}-${cfg.defaultProfile}";
    #   in {
    #     name = ".local/share/applications/${name}.desktop";
    #     value.source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.nix-profile/share/applications/${name}.desktop";
    #   }
    # ) cfg.apps);
  };
}
