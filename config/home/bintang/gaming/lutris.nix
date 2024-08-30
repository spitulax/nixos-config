{ config
, lib
, pkgs
, ...
}: {
  options.configs.gaming.lutris.enable = lib.mkEnableOption "Lutris";

  config = lib.mkIf config.configs.gaming.lutris.enable {
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
  };
}
