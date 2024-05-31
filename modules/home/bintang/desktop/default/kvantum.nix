{ pkgs
, ...
}: {
  home.packages = [
    (pkgs.catppuccin-kvantum.override {
      accent = "Blue";
      variant = "Mocha";
    })
  ];

  xdg.configFile = {
    "Kvantum/kvantum.kvconfig".text = ''
      [General]
      theme=Catppuccin-Mocha-Blue
    '';
    "Kvantum/Catppuccin-Mocha-Blue" = {
      source = "${pkgs.catppuccin-kvantum}/share/Kvantum/Catppuccin-Mocha-Blue";
      recursive = true;
    };
  };
}
