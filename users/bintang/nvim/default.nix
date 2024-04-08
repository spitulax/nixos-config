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
      gopls
      nil
      rust-analyzer
      clang-tools

      luajit # required for luarocks.nvim
    ];
    extraPython3Packages = ps: with ps; [
      pynvim
    ];
  };

  home.file = {
    ".config/nvim/lua/custom" = {
      source = ./custom;
      recursive = true;
    };
    ".config/nvim/lua" = {
      source = "${nvchad}/lua";
      recursive = true;
    };
    ".config/nvim/init.lua" = {
      source = "${nvchad}/init.lua";
    };
    ".config/nvim/lazy-lock.json" = {
      source = ./lazy-lock.json;
    };
  };
}
