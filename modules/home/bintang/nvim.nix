{ pkgs
, ...
}: {
  programs.neovim = {
    enable = true;
    withNodeJs = false;
    withPython3 = true;
    withRuby = false;
    extraPackages = with pkgs; [
      # LSPs
      lua-language-server
      gopls
      nil
      rust-analyzer
      clang-tools

      luajit # required for luarocks.nvim
    ];
    # extraPython3Packages = ps: with ps; [
    #   pynvim
    # ];
  };

  home.file = {
    ".config/nvim/lua" = {
      source = ./nvim/lua;
      recursive = true;
    };
    ".config/nvim/init.lua" = {
      source = ./nvim/init.lua;
    };
    ".config/nvim/lazy-lock.json" = {
      source = ./nvim/lazy-lock.json;
    };
  };

  home.packages = with pkgs; [
    # For :TSInstallFromGrammar
    # tree-sitter
    # nodePackages.nodejs
  ];
}
