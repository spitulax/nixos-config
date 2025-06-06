{ pkgs
, ...
}: {
  home.file.".XCompose".source = "${pkgs.keyd}/share/keyd/keyd.compose";
}
