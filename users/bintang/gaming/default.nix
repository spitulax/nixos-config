{ config
, pkgs
, inputs
, ...
}: {
  imports = [
    ./games.nix
  ];

  home.packages = with pkgs; [
    mangohud
    # protontricks
    # winetricks

    # These packages is needed for lutris
    lutris
    gamescope
    # dxvk
    # vkd3d-proton
  ] ++ (with pkgs.inputs.nix-gaming; [
    # FAILED: {https://github.com/fufexan/nix-gaming/pull/86}
    # dxvk
    # vkd3d-proton

    # proton-ge
    # wine-ge
  ]);
}
