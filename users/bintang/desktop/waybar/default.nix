{ pkgs
, inputs
, ...
}: {
  programs.waybar = {
    enable = true;
    package = inputs.waybar.packages.${pkgs.system}.waybar.override {
      inherit pkgs;
    };
  };

  home.file = {
    ".config/waybar/config.jsonc".source = ./config.jsonc;
    ".config/waybar/style.css".source = ./style.css;
    ".config/waybar/catppuccin-mocha.css".source = ./catppuccin-mocha.css;
    ".config/waybar/scripts" = {
      source = ./scripts;
      recursive = true;
    };
  };
}
