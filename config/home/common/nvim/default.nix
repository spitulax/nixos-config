{ config
, pkgs
, lib
, hmLib
, ...
}:
let
  cfg = config.configs.neovim;
in
{
  imports = [
    ./lazyup.nix
  ];

  options.configs.neovim.enable = lib.mkEnableOption "neovim";

  config = lib.mkIf cfg.enable {
    programs.neovim = {
      enable = true;
      withNodeJs = false;
      withPython3 = true;
      withRuby = false;
      extraWrapperArgs = [
        "--prefix"
        "PATH"
        ":"
        "${lib.makeBinPath (with pkgs; [
          lua51Packages.lua
          lua51Packages.luarocks-nix
        ])}"
      ];
      # extraPackages = with pkgs; [
      #
      # ];
      # extraPython3Packages = ps: with ps; [
      #   pynvim
      # ];
    };

    home.file = {
      ".config/nvim/lua" = {
        source = ./lua;
        recursive = true;
      };
      ".config/nvim/init.lua" = {
        source = ./init.lua;
      };
      ".config/nvim/lazy-lock.json" = {
        source = ./lazy-lock.json;
      };
    };

    home.packages = with pkgs; [
      # For :TSInstallFromGrammar
      # tree-sitter
      # nodePackages.nodejs
      wakatime-cli
    ];

    configs.cli.aliases.extraAliases.vim = "nvim";

    home.activation = {
      nvimRemoveConfigCache = hmLib.hm.dag.entryAfter [ "writeBoundary" ] ''
        if [[ -v XDG_CACHE_HOME ]]; then
          CACHE="$XDG_CACHE_HOME"
        else
          CACHE="$HOME/.cache"
        fi
        NVIM_CACHE="$CACHE/nvim/luac"
        if [[ -d "$NVIM_CACHE" ]]; then
          run rm -r "$NVIM_CACHE"
        fi
      '';
    };
  };
}
