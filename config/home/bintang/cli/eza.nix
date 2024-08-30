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

  inherit (myLib)
    mkAliasOptions
    mkAliasConfig
    ;

  cfg = config.configs.cli.eza;

  shellAlias = {
    ls = "eza -G -laH --no-user --color=always --group-directories-first --icons";
    lr = "eza -G --no-user --color=always --group-directories-first --icons";
    la = "eza -G -a --no-user --color=always --group-directories-first --icons";
    ll = "eza -G -lH --no-user --color=always --group-directories-first --icons";
    lt = "eza -G -T --no-user --color=always --group-directories-first --icons --long -L";
  };
in
{
  options.configs.cli.eza = {
    enable = mkEnableOption "eza" // {
      default = true;
    };
    alias = mkAliasOptions { desc = "aliasing `eza` to `ls`"; };
  };

  config = mkMerge [
    (mkIf cfg.enable {
      home.packages = with pkgs; [
        eza
      ];
    })

    {
      programs = mkAliasConfig {
        config = cfg.alias;
        aliases = shellAlias;
      };
    }
  ];
}
