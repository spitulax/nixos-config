{ pkgs
, inputs
, ...
}:
let
  inherit (inputs) nvchad;
in
{
  programs.neovim = {
    enable = true;
    withNodeJs = true;
    withPython3 = true;
    withRuby = true;
    extraPackages = with pkgs; [
      # LSPs
      lua-language-server
      clang-tools
      gopls
      nil
      rust-analyzer

      # Required
      luajit # for luarocks.nvim
    ];
    extraPython3Packages = ps: with ps; [
      pynvim
    ];
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
