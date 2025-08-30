{ config
, lib
, ...
}: {
  options.configs.cli.cava.enable = lib.mkEnableOption "cava";

  config = lib.mkIf config.configs.cli.cava.enable {
    programs.cava = {
      enable = true;
      settings = {
        # TODO: global theming
        color = {
          background = "'#191724'";
          gradient = 1;
          gradient_count = 6;
          gradient_color_1 = "'#31748f'";
          gradient_color_2 = "'#9ccfd8'";
          gradient_color_3 = "'#c4a7e7'";
          gradient_color_4 = "'#ebbcba'";
          gradient_color_5 = "'#f6c177'";
          gradient_color_6 = "'#eb6f92'";
        };
      };
    };
  };
}
