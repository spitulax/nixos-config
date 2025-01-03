{ config
, pkgs
, outputs
, ...
}: {
  environment = {
    systemPackages = outputs.vars.commonPackage pkgs ++ config.configs.extraPackages;
    variables.EDITOR = "nvim";
  };

  programs = {
    nix-ld.enable = false;
    fish.enable = true;
    dconf.enable = true;
  };
}
