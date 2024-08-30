{ config
, pkgs
, lib
, ...
}: {
  config = lib.mkIf config.configs.desktop.enable {
    xdg.configFile = {
      "Kvantum/kvantum.kvconfig".text = ''
        [General]
        theme=MateriaDark
      '';
      "Kvantum/MateriaDark" = {
        source = "${pkgs.materia-kde-theme}/share/Kvantum/MateriaDark";
        recursive = true;
      };
    };
  };
}
