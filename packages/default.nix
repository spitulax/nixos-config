{ pkgs
, lib
, myLib
}: {
  # Simple scripts
  scripts = import ./scripts { inherit pkgs lib myLib; };
}
