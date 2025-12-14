{ pkgs }:
pkgs.mkShell {
  name = "config-shell";
  nativeBuildInputs = with pkgs; [
    go
    gopls
  ];
}
