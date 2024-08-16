{ inputs
, pkgs
, ...
}: {
  programs.bat = {
    enable = true;
    themes = {
      catppuccin = {
        src = inputs.catppuccin-bat;
        file = "themes/Catppuccin Mocha.tmTheme";
      };
    };
    config = {
      theme = "Catppuccin Mocha";
    };
  };

  xdg.configFile."bat/themes" = {
    source = "${inputs.catppuccin-bat}/themes";
    recursive = true;
  };

  home.packages = with pkgs.bat-extras; [
    batgrep
    batman
    batwatch
    # FAILED: https://github.com/NixOS/nixpkgs/issues/332957
    # batdiff
  ];

  programs.fish.shellAliases = {
    man = "batman";
    bgrep = "batgrep";
    bwatch = "batwatch";
    bdiff = "batdiff";
  };
}
