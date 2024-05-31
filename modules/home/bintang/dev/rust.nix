{ pkgs
, ...
}: {
  home.packages = with pkgs; [
    rustc
    cargo
    clippy
    rustfmt
  ];
}
