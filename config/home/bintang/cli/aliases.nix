{ config
, lib
, myLib
, ...
}:
let
  inherit (lib)
    mkOption
    types
    ;

  inherit (myLib)
    mkAliasOptions
    mkAliasConfig
    ;

  cfg = config.configs.cli.aliases;

  commonAliases = {
    # nix shortcuts
    repl = "nix repl .";
    nrepl = "nix repl -f flake:nixpkgs";
    pkgs-user = "nix-store -qR $HOME/.nix-profile";
    pkgs-sys = "nix-store -qR /run/current-system/sw";
    gcroots = "nix-store --gc --print-roots | less";
    profile-hist = "nix profile history --profile";
    upinput = "nix flake lock --update-input";
    # misc. shortcuts
    ".." = "cd ..";
    "..." = "cd ../..";
    q = "exit";
    old = "command";
    j = "jobs";
    f = "fg";
    r = "realpath";
    # colorizer
    grep = "grep --color";
    egrep = "egrep --color";
    fgrep = "fgrep --color";
    # this will wipe the scoll buffer instead of just zt-ing the current prompt
    clear = "printf '\\033[2J\\033[3J\\033[1;1H'";
    # cofirm before overwriting files
    cp = "cp -i";
    mv = "mv -i";
  };
in
{
  options.configs.cli.aliases = {
    enable = mkAliasOptions { desc = "common aliases"; };
    extraAliases = mkOption {
      type = types.attrsOf types.str;
      default = { };
      description = "Extra shell aliases.";
    };
  };

  config = {
    programs = mkAliasConfig {
      config = cfg.enable;
      aliases = commonAliases;
      inherit (cfg) extraAliases;
    };
  };
}
