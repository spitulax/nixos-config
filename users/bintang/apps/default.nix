{ config
, pkgs
, nixosConfig
, ...
}: {
  imports = [
    ./kitty.nix
    ./browser.nix
    ./zapzap.nix
    ./elisa.nix
    ./obs.nix
    ./mpv.nix
    ./bitwarden.nix
  ];

  home.packages = with pkgs; [
    # ferdium # FIX: stuck downloading uhhhhhh....
    aseprite
    krita
  ];
}
