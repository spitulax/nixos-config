{ config
, pkgs
, inputs
, ...
}: {
  imports = [
    inputs.nvchad.homeManagerModules.default
  ];

  programs.neovim = {
    enable = true;
    withNodeJs = true;
    withPython3 = true;
  };

  programs.nvchad = {
    enable = true;
    customDir = ./custom;
  };
}
