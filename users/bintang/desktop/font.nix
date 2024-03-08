{ config
, pkgs
, ...
}: {
  fontProfile = {
    enable = true;

    fonts = with pkgs; [
      # Serifs
      poly
      source-serif
      source-han-serif
      # noto-fonts-cjk-sans

      # Sans serifs
      fira
      source-sans
      source-han-sans
      # noto-fonts-cjk-serif

      # Emoji
      noto-fonts-color-emoji

      # Icons
      material-design-icons
      font-awesome

      # Misc/All
      noto-fonts
      noto-fonts-lgc-plus
    ];
    nerdFonts = [
      "FiraCode"
      "Iosevka"
      "JetBrainsMono"
    ];

    monospace = "Iosevka Nerd Font"; # IOSEVKA SUPREMACY!!!!!!!!!!
    # Other fonts struggle to display some diacritics such as l̩,ŋ̍
    serif = "Poly";
    sansSerif = "Fira Sans";
  };
}
