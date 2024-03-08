{ config
, pkgs
, ...
}: {
  programs.gpg = {
    enable = true;
    publicKeys = [
      {
        source = ../keys/gpg1.asc;
        trust = 5;
      }
    ];
  };
}
