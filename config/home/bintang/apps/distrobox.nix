{ config
, lib
, pkgs
, ...
}:
let
  cfg = config.configs.apps.distrobox;
in
{
  options.configs.apps.distrobox.enable = lib.mkEnableOption "Distrobox.\nNeeds {option}`nixos.docker.enable`";

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      distrobox
      boxbuddy
    ];
  };
}
