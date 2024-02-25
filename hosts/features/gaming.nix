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
    inputs.nix-gaming.nixosModules.steamCompat
  ];

  # Gamemode
  programs.gamemode = {
    enable = true;
    settings = {
      general = {
        igpu_desiredgov = "performance";
        igpu_power_threshold = -1;
        renice = 20;
      };
    };
  };
  boot.kernelModules = [ "linux_xanmod" ];

  # Steam
  hardware.steam-hardware.enable = true;
  programs.steam.enable = true;
}
