{ config
, pkgs
, lib
, outputs
, nixosConfig
, ...
}: {
  programs.rbw = {
    enable = true;
    settings = {
      email = "periplep@gmail.com";
      pinentry = "gnome3";
    };
  };
}
