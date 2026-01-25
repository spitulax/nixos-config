{ config
, pkgs
, ...
}: {
  environment = {
    systemPackages = pkgs.myArgs.vars.commonPackage pkgs ++ config.configs.extraPackages;
    variables.EDITOR = "nvim";
  };

  programs = {
    nix-ld.enable = true;
    fish.enable = true;
    dconf.enable = true;
  };
}
