{ whitesur-cursors
, makeWrapper
, inkscape
, xcursorgen
, stdenvNoCC
}:
stdenvNoCC.mkDerivation {
  inherit (whitesur-cursors) pname version src;

  nativeBuildInputs = [
    makeWrapper
    inkscape
    xcursorgen
  ];

  patches = [
    ./patch.patch
  ];

  postPatch = ''
    patchShebangs ./build.sh
  '';

  buildPhase = ''
    runHook preBuild

    ./build.sh

    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall

    install -dm 755 $out/share/icons/WhiteSur-cursors
    cp -r dist/* $out/share/icons/WhiteSur-cursors

    runHook postInstall
  '';
}
