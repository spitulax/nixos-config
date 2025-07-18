{ config
, pkgs
, lib
, ...
}:
let
  cfg = config.configs.desktop.screenshot;
in
{
  options.configs.desktop.screenshot = {
    enable = lib.mkEnableOption "Screenshot";
  };

  config = lib.mkIf cfg.enable {
    home.packages = [
      pkgs.mypkgs.gripper
    ];
  };
}
