{ pkgs
, inputs
, ...
}: {
  imports = [
    ./games.nix
  ];

  home.packages = with pkgs; [
    mangohud
    winetricks

    lutris
    gamescope
    # dxvk
    # vkd3d-proton
  ] ++ (with inputs.nix-gaming.packages.${pkgs.system}; [
    # FAILED: {https://github.com/fufexan/nix-gaming/pull/86}
    # dxvk
    # vkd3d-proton

    wine-ge
  ]);
}
