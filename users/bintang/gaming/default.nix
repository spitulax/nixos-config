{ config
, pkgs
, inputs
, ...
}:
let
  nix-gaming-pkgs = inputs.nix-gaming.packages.${pkgs.system};
in
{
  imports = [
    ./games.nix
  ];

  home.packages = with pkgs; [
    mangohud
    # protontricks
    # winetricks

    # These packages is needed for lutris
    # lutris
    # gamescope
    # dxvk
    # vkd3d-proton
  ] ++ (with nix-gaming-pkgs; [
    # FAILED: {https://github.com/fufexan/nix-gaming/pull/86}
    # dxvk
    # vkd3d-proton

    # proton-ge
    # wine-ge
  ]);
}
