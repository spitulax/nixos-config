{ config
, lib
, pkgs
, ...
}:
let
  inherit (lib)
    mkEnableOption
    mapAttrs
    mapAttrsToList
    filterAttrs
    flatten
    mkMerge
    mkIf
    ;

  cfg = config.configs.dev;

  modules = with pkgs; {
    # Languages #

    cpp = [
      man-pages
      (hiPrio gcc)
      clang
      clang-tools
      meson
      ninja
      pkg-config
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
      odin-git
      (ols.override {
        odinRoot = "${odin-git}/share";
      })
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
      rust-bin.beta.latest.default
    ];

    # Tools #

    debugger = [
      gdb
      lldb
      valgrind
    ];

    # NOTE: Needs {NixOS Config}`configs.perf.enable`
    benchmark = [
      hyperfine
      cargo-flamegraph
      inferno
    ];

    misc = [
      gnumake
    ];
  };
in
{
  options.configs.dev =
    mapAttrs
      (k: _: mkEnableOption "development utility: ${k}")
      modules;

  config = mkMerge [
    {
      home.packages =
        flatten
          (mapAttrsToList
            (k: _: modules.${k})
            (filterAttrs
              (_: v: v)
              cfg));
    }

    (mkIf cfg.rust {
      home.file.".cargo/config.toml".text = ''
        [build]
        target-dir = "${config.home.homeDirectory}/.cargo/target"

        [profile.benchmark]
        inherits = "release"
        debug = "line-tables-only"
      '';
    })
  ];
}
