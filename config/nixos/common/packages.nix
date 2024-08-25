{ config
, pkgs
, outputs
, ...
}:
{
  environment.systemPackages = outputs.vars.commonPackage pkgs ++ config.configs.extraPackages;
  programs.nix-ld.enable = false;
  programs.fish.enable = true;
  programs.dconf.enable = true;
  environment.variables.EDITOR = "nvim";
}
