{ config
, pkgs
, ...
}: {
  programs.neovim = {
    enable = true;
    withNodeJs = true;
    withPython3 = true;
  };
}
