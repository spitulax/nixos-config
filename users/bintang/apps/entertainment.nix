{ pkgs
, inputs
, ...
}: {
  home.packages = with pkgs; [
    ani-cli
    mangal
  ];
}
