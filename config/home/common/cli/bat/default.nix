{ config
, lib
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
    alias
    ;

  cfg = config.configs.cli.bat;

  aliases = {
    man = "batman";
    bgrep = "batgrep";
    bwatch = "batwatch";
    bdiff = "batdiff";
  };
in
{
  options.configs.cli.bat = {
    enable = mkEnableOption "bat";
    alias = alias.mkOptions { desc = "some `bat` programs"; };
  };

  config = mkMerge [
    (mkIf cfg.enable {
      programs.bat = {
        enable = true;
        config = {
          theme = "Rose-Pine";
        };
      };

      # TODO: global theming
      xdg.configFile."bat/themes" = {
        source = ./themes;
        recursive = true;
      };

      home.packages = with pkgs.bat-extras; [
        batgrep
        batman
        batwatch
        batdiff
      ];
    })

    (mkIf cfg.enable {
      programs = alias.mkConfig {
        config = cfg.alias;
        inherit aliases;
      };
    })
  ];
}
