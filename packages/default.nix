{ pkgs
, ...
}: {
  # Simple scripts
  plasma-restartshell = pkgs.callPackage ./plasma-restartshell { };
  reminder = pkgs.callPackage ./reminder { };
}
