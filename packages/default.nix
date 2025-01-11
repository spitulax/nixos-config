{ pkgs }:
let
  inherit (pkgs) myCallPackage;
in
{
  # Simple scripts
  scripts = myCallPackage ./scripts { };
}
