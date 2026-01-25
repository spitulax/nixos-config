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

  # ISSUE:
  # Are webdevs stupid?
  # pkgs.buildEnv error: two given paths contain a conflicting subpath:
  # `/nix/store/k3pcjz4kgiyn54m3jm2zb0rh4l0r7l9w-prettier-3.6.2/LICENSE' and
  # `/nix/store/zq21wnzgh6yf544m66qbh3r8qhwqgd8f-composer-2.8.11/LICENSE'
  composer = with pkgs; hiPrio phpPackages.composer;

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

    flutter = {
      desc = "Flutter";
      pkgs = [
        flutter
        android-studio
        android-tools
        openjdk
        mesa-demos
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
        pnpm
        typescript
        typescript-language-server
        svelte-language-server
        prettier
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
        # Enable `rust-overlay` first (not recommended)
        # rust-analyzer
        # rust-bin.stable.latest.default
      ];
    };

    php = {
      desc = "PHP";
      pkgs = [
        php
        phpactor
        mago
        composer
        laravel
      ];
    };

    text = {
      desc = "Text";
      pkgs = [
        prettier
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

    # Needs {NixOS Config}`configs.perf.enable`
    # TODO: Use `nixosConfig` input for assertion?
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

    (lib.mkIf cfg.flutter.enable {
      home.sessionVariables = rec {
        ANDROID_SDK_ROOT = "${config.xdg.dataHome}/android/sdk";
        ANDROID_HOME = ANDROID_SDK_ROOT;
      };
    })
  ];
}
