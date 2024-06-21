{ pkgs
, ...
}: {
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
}
