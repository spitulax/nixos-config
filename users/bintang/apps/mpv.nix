{ config
, pkgs
, ...
}: {
  programs.mpv = {
    enable = true;
    config = {
      hwdec = "auto-safe";
    };
  };
}
