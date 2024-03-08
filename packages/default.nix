{ pkgs
, ...
}: {
  # Simple scripts
  plasma-restartshell = pkgs.callPackage ./plasma-restartshell { };
}
