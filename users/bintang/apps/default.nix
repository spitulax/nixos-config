{ config
, pkgs
, nixosConfig
, ...
}: {
  imports = [
    ./kitty.nix
    ./browser.nix
    ./zapzap.nix
    ./obs.nix
    ./mpv.nix
    ./bitwarden.nix
    ./thunar.nix
  ];

  home.packages = with pkgs; [
    pixelorama
    krita
  ];
}
