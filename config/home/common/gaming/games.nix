{ config
, pkgs
, myLib
, ...
}:
let
  inherit (myLib.hmHelper)
    mkPkgsOptions
    mkPkgsConfig
    ;

  cfg = config.configs.gaming.games;

  modules = with pkgs; {
    osu = {
      desc = "Osu!";
      pkgs = [
        osu-lazer
      ];
    };
  };
in
{
  options.configs.gaming.games = mkPkgsOptions { inherit modules; };

  config = {
    home.packages = mkPkgsConfig { inherit modules cfg; };
  };
}
