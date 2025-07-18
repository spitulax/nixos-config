{ config
, lib
, inputs
, pkgs
, myLib
, ...
}:
let
  inherit (lib)
    mkEnableOption
    mkIf
    mkMerge
    ;

  inherit (myLib.hmHelper)
    mkAliasOptions
    mkAliasConfig
    ;

  cfg = config.configs.cli.bat;

  aliases = {
    man = "batman";
    bgrep = "batgrep";
    bwatch = "batwatch";
    bdiff = "batdiff";
    cat = "bat --style numbers";
  };
in
{
  options.configs.cli.bat = {
    enable = mkEnableOption "bat";
    alias = mkAliasOptions { desc = "some `bat` programs"; };
  };

  config = mkMerge [
    (mkIf cfg.enable {
      programs.bat = {
        enable = true;
        themes = {
          # TODO: global theming
          catppuccin = {
            src = inputs.catppuccin-bat;
            file = "themes/Catppuccin Mocha.tmTheme";
          };
        };
        config = {
          theme = "Catppuccin Mocha";
        };
      };

      # TODO: global theming
      xdg.configFile."bat/themes" = {
        source = "${inputs.catppuccin-bat}/themes";
        recursive = true;
      };

      home.packages = with pkgs.bat-extras; [
        batgrep
        batman
        batwatch
        # FAILED: https://github.com/NixOS/nixpkgs/issues/332957
        # batdiff
      ];
    })

    (mkIf cfg.enable {
      programs = mkAliasConfig {
        config = cfg.alias;
        inherit aliases;
      };
    })
  ];
}
