{ config
, pkgs
, lib
, ...
}:
let
  theme = {
    # This theme does not support qt6 yet
    package = pkgs.materia-kde-theme;
    name = "MateriaDark";
  };
in
{
  config = lib.mkIf config.configs.desktop.enable {
    xdg.configFile = {
      "Kvantum/kvantum.kvconfig".text = ''
        [General]
        theme=${theme.name}
      '';
      "Kvantum/MateriaDark" = {
        source = "${theme.package}/share/Kvantum/${theme.name}";
        recursive = true;
      };
    };
  };
}
