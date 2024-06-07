{ stdenv
, lib
, meson
, ninja
, pkg-config

, debug ? false
}:
let
  version = with lib; elemAt
    (pipe (readFile ../meson.build) [
      (splitString "\n")
      (filter (hasPrefix "  version : "))
      head
      (splitString " : ")
      last
      (splitString "'")
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
