{ pkgs
, config
, ...
}: {
  home.packages = with pkgs; [
    libsForQt5.qt5ct
    kdePackages.qt6ct
  ];

  qt = {
    enable = true;
    # style = {
    #   name = "Adwaita-dark";
    #   package = pkgs.adwaita-qt;
    # };
  };
}
