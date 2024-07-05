{ pkgs
, config
, ...
}: {
  home.packages = with pkgs; [
    rust-analyzer
    rust-bin.stable.latest.default
  ];

  home.sessionPath = [
    "${config.home.homeDirectory}/.cargo/bin"
  ];
}
