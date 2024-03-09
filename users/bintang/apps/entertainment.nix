{ pkgs
, inputs
, ...
}: {
  home.packages = with pkgs; [
    ani-cli
    mangal
  ] ++ [
    inputs.lobster.packages.${pkgs.system}.lobster
  ];
}
