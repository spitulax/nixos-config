{ lib
, stdenv
, odin
, gitHubPkg
, cmark
}:
stdenv.mkDerivation (
  (gitHubPkg {
    owner = "odin-lang";
    repo = "pkg.odin-lang.org";
    ref = "master";
    dirname = "odin-doc";
  }) // {
    pname = "odin-doc";

    nativeBuildInputs = [
      odin
      cmark
    ];

    buildInputs = [
      cmark
    ];

    buildPhase = ''
      runHook preBuild

      odin build . -out:odin-doc -extra-linker-flags:"-L${cmark}/lib"

      runHook postBuild
    '';

    installPhase = ''
      runHook preInstall

      install -Dm755 odin-doc -t $out/bin

      runHook postInstall
    '';

    meta = with lib; {
      inherit (odin.meta) platforms;
      description = "Document generation tool for Odin";
      mainProgram = "odin-doc";
      homepage = "https://github.com/odin-lang/pkg.odin-lang.org";
      maintainers = with maintainers; [ spitulax ];
    };
  }
)
