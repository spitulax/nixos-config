{ config
, pkgs
, ...
}: {
  home.sessionVariables.XCOMPOSEFILE = "$XDG_CONFIG_HOME/XCompose";
  home.file.".config/XCompose".source = ./XCompose;
}
