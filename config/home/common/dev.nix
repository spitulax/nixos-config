{ config
, pkgs
, lib
, myLib
, ...
}:
let
  inherit (myLib.hmHelper)
    packages
    ;

  cfg = config.configs.dev;

  modules = with pkgs; {
    # Languages #

    cpp = {
      desc = "C/C++";
      pkgs = [
        man-pages
        (hiPrio gcc)
        clang
        clang-tools
        meson
        ninja
        pkg-config
      ];
    };

    go = {
      desc = "Go";
      pkgs = [
        go
        gopls
        golangci-lint
      ];
    };

    godot = {
      desc = "Godot Engine";
      pkgs = [
        godot_4
        gdtoolkit_4
      ];
    };

    javascript = {
      desc = "JavaScript and TypeScript";
      pkgs = [
        nodePackages.nodejs
        typescript
        typescript-language-server
      ];
    };

    lua = {
      desc = "Lua";
      pkgs = [
        luajitPackages.lua
        stylua
        lua-language-server
      ];
    };

    nix = {
      desc = "Nix";
      pkgs = [
        nil
        statix
        nixpkgs-fmt
        nixfmt-rfc-style
        nurl
      ];
    };

    odin = {
      desc = "Odin";
      pkgs = with mypkgs; [
        odin-git
        (ols.override {
          odinRoot = "${odin-git}/share";
        })
        odin-doc
      ];
    };

    python = {
      desc = "Python";
      pkgs = [
        (python3.withPackages (ps: with ps; [
          python-lsp-server
          pylsp-mypy
          flake8
          black
        ]))
      ];
    };

    rust = {
      desc = "Rust";
      pkgs = [
        rust-analyzer
        rust-bin.stable.latest.default
      ];
    };

    php = {
      desc = "PHP";
      pkgs = [
        php
        phpactor
        mago
        phpPackages.composer
        laravel
        nodePackages.nodejs
      ];
    };

    text = {
      desc = "Text";
      pkgs = [
        deno
      ];
    };

    # Tools #

    debugger = {
      desc = "Debuggers";
      pkgs = [
        gdb
        lldb
        valgrind
      ];
    };

    # NOTE: Needs {NixOS Config}`configs.perf.enable`
    benchmark = {
      desc = "Benchmarking";
      pkgs = [
        hyperfine
        cargo-flamegraph
        inferno
      ];
    };

    make = {
      desc = "Make";
      pkgs = [
        gnumake
      ];
    };

    misc = {
      desc = "Miscellaneous";
      pkgs = [
        tokei
      ];
    };
  };
in
{
  options.configs.dev = packages.mkOptions {
    desc = n: "development utility: ${n}";
    inherit modules;
  };

  config = lib.mkMerge [
    {
      home = {
        packages = packages.mkConfig { inherit modules cfg; };
      };
    }

    (lib.mkIf cfg.misc.enable {
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
