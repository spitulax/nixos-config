{ whitesur-cursors
, makeWrapper
, inkscape
, xorg
, stdenvNoCC
}:
stdenvNoCC.mkDerivation {
  inherit (whitesur-cursors) pname version src;

  nativeBuildInputs = [
    makeWrapper
    inkscape
    xorg.xcursorgen
  ];

  patches = [
    ./size.patch
  ];

  patchPhase = ''
    runHook prePatch

    patchShebangs ./build.sh

    runHook postPatch
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
