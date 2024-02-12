{ config
, pkgs
, ...
}: {
  home.keyboard.options = [ "compose:ralt" ];
  home.sessionVariables.XCOMPOSEFILE = "$XDG_CONFIG_HOME/XCompose";
  home.file.".config/XCompose".source = ./XCompose;
}
