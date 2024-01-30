{ config
, pkgs
, ...
}: {
  home.packages = [ pkgs.python3 ] ++ (with pkgs.python311Packages; [
    pip
    pynvim
  ]);
}
