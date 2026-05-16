{ callPackage
, myLib
, ...
}:
let
  inherit (myLib.drv)
    ignore
    ;
in
{
  # KEEP THE LIST ALPHABETICALLY SORTED!
  crt = ignore (callPackage ./crt { });
  gripper = callPackage ./gripper { };
  pasteme = callPackage ./pasteme { };
}

