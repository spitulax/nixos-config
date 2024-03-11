{ pkgs
, ...
}: {
  home.packages = with pkgs; [
    plasma-restartshell
    reminder
  ];
}
