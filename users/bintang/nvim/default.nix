{ config
, pkgs
, inputs
, ...
}:
let
  nvchad = inputs.nvchad;
in
{
  programs.neovim = {
    enable = true;
    withNodeJs = true;
    withPython3 = true;
  };

  home.file.".config/nvim/lua/custom" = {
    source = ./custom;
    recursive = true;
  };

  home.file.".config/nvim/lua" = {
    source = "${nvchad}/lua";
    recursive = true;
  };

  home.file.".config/nvim/init.lua".source = "${nvchad}/init.lua";
}
