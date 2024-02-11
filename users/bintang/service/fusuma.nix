{ config
, pkgs
, ...
}: {
  services.fusuma = {
    enable = false;
    extraPackages = with pkgs; [ coreutils xdotool ];
    # TODO: Actually add fusuma config {https://github.com/iberianpig/fusuma/wiki}
    settings = { };
  };
}
