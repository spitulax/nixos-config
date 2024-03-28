{ pkgs
, ...
}: {
  home.packages = with pkgs; [
    (python3.withPackages (ps: with ps; [
      # Some python packages
    ]))
  ];
}
