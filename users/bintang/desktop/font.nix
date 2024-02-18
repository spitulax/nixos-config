{ config
, pkgs
, ...
}: {
  fontProfile = {
    enable = true;

    fonts = with pkgs; [
      poly
      fira
      noto-fonts-cjk-serif
      noto-fonts-cjk-sans
    ];
    nerdFonts = [
      "FiraCode"
      "Iosevka"
      "JetBrainsMono"
    ];

    monospace = "Iosevka Nerd Font";  # IOSEVKA SUPREMACY!!!!!!!!!!
                                      # Other fonts struggle to display some diacritics such as l̩,ŋ̍
    serif = "Poly";
    sansSerif = "Fira Sans";
  };
}
