{ config
, pkgs
, lib
, ...
}:
let
  theme = {
    package = pkgs.rose-pine-kvantum;
    name = "rose-pine-iris";
  };
in
{
  config = lib.mkIf config.configs.desktop.enable {
    xdg.configFile = {
      "Kvantum/kvantum.kvconfig".text = ''
        [General]
        theme=${theme.name}
      '';
      "Kvantum/${theme.name}" = {
        source = "${theme.package}/share/Kvantum/themes/${theme.name}";
        recursive = true;
      };
    };
  };
}
