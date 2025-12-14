{ lib
, gitHubPkg
, makeWrapper
, xorg
, librsvg
, stdenvNoCC
}:
let
  pkg = gitHubPkg {
    owner = "vinceliuice";
    repo = "WhiteSur-cursors";
    ref = "master";
    dirname = "whitesur-cursors";
  };
in
stdenvNoCC.mkDerivation (pkg // {
  pname = "whitesur-cursors";

  nativeBuildInputs = [
    makeWrapper
    librsvg
    xorg.xcursorgen
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

  meta = {
    description = "WhiteSur cursors theme for linux desktops";
    homepage = "https://github.com/vinceliuice/WhiteSur-cursors";
    platforms = lib.platforms.linux;
    license = lib.licenses.gpl3Only;
    maintainers = with lib.maintainers; [ spitulax ];
  };
})
