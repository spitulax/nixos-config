{ stdenv
, lib
, odin

, debug ? false
}:
let
  version = with lib; elemAt
    (pipe (readFile ../build.sh) [
      (splitString "\n")
      (filter (hasPrefix "PROG_VERSION="))
      head
      (splitString "=")
      last
      (splitString "\"")
    ]) 1;
in
stdenv.mkDerivation rec {
  pname = "foobar";
  inherit version;
  src = lib.cleanSource ./..;

  nativeBuildInputs = [
    odin
  ];

  buildInputs = [

  ];

  patchPhase = ''
    runHook prePatch

    patchShebangs ./build.sh

    runHook postPatch
  '';

  buildPhase = ''
    runHook preBuild

    ./build.sh ${if debug then "debug" else "release"}

    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall

    install -Dm755 build/${pname} -t $out/bin

    runHook postInstall
  '';
}
