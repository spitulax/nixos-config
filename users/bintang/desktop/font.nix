{ config
, pkgs
, ...
}: {
  fontProfile = {
    enable = true;

    fonts = with pkgs; [
      poly
      fira
    ];
    nerdFonts = [
      "FiraCode"
      # "Iosevka" # FIX: installing Iosevka is stuck at building Iosevka.tar.xz
      "JetBrainsMono"
    ];

    monospace = "FiraCode Nerd Font";
    serif = "Poly";
    sansSerif = "Fira Sans";
  };
}
