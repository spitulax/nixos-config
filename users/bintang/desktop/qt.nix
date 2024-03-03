{ pkgs
, config
, ...
}: {
  qt = {
    enable = true;
    # style = {
    #   name = "Adwaita-dark";
    #   package = pkgs.adwaita-qt;
    # };
  };
}
