{ config
, pkgs
, ...
}: {
  home.keyboard.options = [ "compose:ralt" ];
  xdg.configFile."XCompose".source = ./XCompose;
}
