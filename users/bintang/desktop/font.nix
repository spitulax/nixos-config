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
      font-awesome

      # Misc/All
      noto-fonts
      noto-fonts-lgc-plus
    ];
    nerdFonts = [
      # https://github.com/NixOS/nixpkgs/blob/nixos-unstable/pkgs/data/fonts/nerdfonts/shas.nix
      "NerdFontsSymbolsOnly"
      "Iosevka"
    ];

    monospace = "Iosevka Nerd Font";
    serif = "Source Serif 3";
    sansSerif = "Source Sans 4";
  };
}
