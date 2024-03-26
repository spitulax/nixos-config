{ pkgs
, ...
}: {
  fonts = {
    fontDir.enable = true;

    fontconfig = {
      enable = true;
      defaultFonts = {
        serif = [ "Source Serif 3" ];
        sansSerif = [ "Fira Sans" ];
        monospace = [ "Iosevka Nerd Font" ];
        emoji = [ "Noto Color Emoji" ];
      };
    };

    packages = with pkgs; [
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

      # Nerdfonts
      (nerdfonts.override {
        fonts = [
          # https://github.com/NixOS/nixpkgs/blob/nixos-unstable/pkgs/data/fonts/nerdfonts/shas.nix
          "NerdFontsSymbolsOnly"
          "Iosevka"
        ];
      })
    ];
  };
}
