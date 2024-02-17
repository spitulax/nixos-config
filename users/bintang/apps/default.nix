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
}
