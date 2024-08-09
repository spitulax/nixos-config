{ pkgs
, ...
}: {
  home.packages = with pkgs; [
    (lutris.override {
      steamSupport = false;
    })
    # dxvk
    # vkd3d-proton
  ] ++ (with pkgs.inputs.nix-gaming; [
    # FAILED: {https://github.com/fufexan/nix-gaming/pull/86}
    # dxvk
    # vkd3d-proton
  ]);
}
