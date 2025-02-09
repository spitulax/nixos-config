{ pkgs
, ...
}:
let
  nerdfonts = pkgs.nerd-fonts.iosevka;
in
{
  terminal = {
    font = "${nerdfonts}/share/fonts/truetype/NerdFonts/IosevkaNerdFont-Regular.ttf";
    colors = {
      foreground = "#CDD6F4";
      background = "#101020";
      cursor = "#F9E2AF";
      color0 = "#45475A";
      color8 = "#585B70";
      color1 = "#F38BA8";
      color9 = "#F38BA8";
      color2 = "#A6E3A1";
      color10 = "#A6E3A1";
      color3 = "#F9E2AF";
      color11 = "#F9E2AF";
      color4 = "#89B4FA";
      color12 = "#89B4FA";
      color5 = "#F5C2E7";
      color13 = "#F5C2E7";
      color6 = "#94E2D5";
      color14 = "#94E2D5";
      color7 = "#BAC2DE";
      color15 = "#A6ADC8";
    };
  };
}
