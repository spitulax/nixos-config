# FIXME: Retire this, but move the helper somewhere
{ pkgs
, myLib
}:
let
  inherit (pkgs) myCallPackage;
in
{
  # Simple scripts
  scripts = myCallPackage ./scripts { };

  helper = pkgs.callPackage myLib.helpers.helper { };
}
