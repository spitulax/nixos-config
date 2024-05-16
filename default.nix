{ pkgs ? import <nixpkgs> { } }: {
  lib = import ./lib { inherit (pkgs) lib; };
  path = ./.;
}
