{ callPackage
, myLib
, ...
}:
let
  inherit (myLib.drv)
    unmaintain
    ;
in
{
  # KEEP THE LIST ALPHABETICALLY SORTED!
  crt = callPackage ./crt { };
  gripper = callPackage ./gripper { };
  pasteme = callPackage ./pasteme { };
}

