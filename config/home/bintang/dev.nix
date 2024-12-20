{ config
, lib
, pkgs
, myLib
, ...
}:
let
  inherit (lib)
    mkEnableOption
    mapAttrs
    mapAttrsToList
    filterAttrs
    flatten
    ;

  inherit (myLib)
    importIn
    ;

  cfg = config.configs.dev;

  modules = with pkgs; {
    cpp = [
      man-pages
      (hiPrio gcc)
      clang
      clang-tools
      meson
      ninja
      pkg-config
    ];

    debugger = [
      gdb
      lldb
      valgrind
    ];

    go = [
      go
      gopls
      golangci-lint
    ];

    godot = [
      godot_4
      gdtoolkit_4
    ];

    javascript = [
      nodePackages.nodejs
      typescript
      typescript-language-server
      deno
    ];

    lua = [
      luajitPackages.lua
      stylua
      lua-language-server
    ];

    nix = [
      nil
      statix
      nixpkgs-fmt
      nixfmt-rfc-style
      nurl
    ];

    odin = with mypkgs; [
      odin-nightly
      ols
      odin-doc
    ];

    python = [
      (python3.withPackages (ps: with ps; [
        python-lsp-server
        flake8
        black
      ]))
    ];

    rust = [
      rust-analyzer
      rust-bin.stable.latest.default
    ];

    tools = [
      gnumake
    ];
  };
in
{
  options.configs.dev =
    mapAttrs
      (k: _: mkEnableOption "development utility: ${k}")
      modules;

  config = {
    home.packages =
      flatten
        (mapAttrsToList
          (k: _: modules.${k})
          (filterAttrs
            (_: v: v)
            cfg));
  };
}
