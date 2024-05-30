{ stdenv
, lib
, meson
, ninja
, pkg-config

, debug ? false
}:
let
  version = with lib; elemAt
    (pipe (readFile ../src/main.c) [
      (splitString "\n")
      (filter (hasPrefix "#define PROG_VERSION"))
      head
      (splitString " ")
      last
      (splitString "\"")
    ]) 1;
in
stdenv.mkDerivation {
  pname = "foobar";
  inherit version;
  src = lib.cleanSource ./..;

  nativeBuildInputs = [
    meson
    ninja
    pkg-config
  ];

  buildInputs = [

  ];

  mesonBuildType = if debug then "debug" else "release";
}
