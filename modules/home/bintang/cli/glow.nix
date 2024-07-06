{ pkgs
, ...
}: {
  home.packages = with pkgs; [
    glow
  ];

  xdg.configFile."glow/glow.yml".text = ''
    style: "auto"
    local: false
    mouse: true
    pager: true
    width: 80
  '';
}
