{ config
, pkgs
, myLib
, ...
}:
let
  inherit (myLib.hmHelper)
    packages
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
  options.configs.gaming.games = packages.mkOptions { inherit modules; };

  config = {
    home.packages = packages.mkConfig { inherit modules cfg; };
  };
}
