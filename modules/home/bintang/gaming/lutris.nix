{ pkgs
, ...
}: {
  home.packages = with pkgs; [
    (lutris.override {
      steamSupport = false;
    })
    # dxvk
    # vkd3d-proton
  ] ++ (with inputs.nix-gaming.packages.${pkgs.system}; [
    # FAILED: {https://github.com/fufexan/nix-gaming/pull/86}
    # dxvk
    # vkd3d-proton
  ]);
}
