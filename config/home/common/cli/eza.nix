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
    ;

  inherit (myLib.hmHelper)
    alias
    ;

  cfg = config.configs.cli.eza;

  shellAlias = {
    ls = "eza -G -laH --no-user --color=always --group-directories-first --icons=always";
    lr = "eza -G --no-user --color=always --group-directories-first --icons=always";
    la = "eza -G -a --no-user --color=always --group-directories-first --icons=always";
    ll = "eza -G -lH --no-user --color=always --group-directories-first --icons=always";
    lt = "eza -G -T --no-user --color=always --group-directories-first --icons=always --long -L";
  };
in
{
  options.configs.cli.eza = {
    enable = mkEnableOption "eza" // {
      default = true;
    };
    alias = alias.mkOptions { desc = "aliasing `eza` to `ls`"; };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      eza
    ];

    programs = alias.mkConfig {
      config = cfg.alias;
      aliases = shellAlias;
    };
  };
}
