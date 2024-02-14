{ config
, pkgs
, ...
}: {
  imports = [
    ./kitty.nix
    ./browser.nix
    ./zapzap.nix
    ./elisa.nix
  ];
}
