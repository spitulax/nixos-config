{ config
, lib
, inputs
, ...
}: {
  options.configs.apps.zathura.enable = lib.mkEnableOption "Zathura PDF reader";

  config = lib.mkIf config.configs.apps.zathura.enable {
    programs.zathura = {
      enable = true;
      options = {
        font = "monospace normal 10";
        guioptions = "sc";
        page-padding = 5;
        pages-per-row = 2;
        advance-pages-per-row = true;
        scroll-page-aware = true;
        show-hidden = true;
        statusbar-home-tilde = true;
        statusbar-page-percent = true;
        window-title-basename = true;
        window-title-home-tilde = true;
        window-width = 1280;
        window-height = 720;
      };
      extraConfig = ''
        include theme
      '';
    };

    xdg.configFile."zathura/theme".source = "${inputs.catppuccin-zathura}/src/catppuccin-mocha";
  };
}
