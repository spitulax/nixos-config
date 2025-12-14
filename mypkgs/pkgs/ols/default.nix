{ lib
, stdenv
, makeWrapper
, odin
, gitHubPkg

, odinRoot ? "${odin}/share"
}:
stdenv.mkDerivation (
  (gitHubPkg {
    owner = "DanielGavin";
    repo = "ols";
    ref = "master";
  }) // {
    pname = "ols";

    nativeBuildInputs = [
      makeWrapper
    ];

    buildInputs = [
      odin
    ];

    patchPhase = ''
      runHook prePatch

      patchShebangs ./build.sh ./odinfmt.sh

      runHook postPatch
    '';

    buildPhase = ''
      runHook preBuild

      ./build.sh && ./odinfmt.sh

      runHook postBuild
    '';

    installPhase = ''
      runHook preInstall

      install -Dm755 ols odinfmt -t $out/bin
      wrapProgram $out/bin/ols --set-default ODIN_ROOT ${odinRoot}

      runHook postInstall
    '';

    meta = with lib; {
      inherit (odin.meta) platforms;
      description = "Language server for Odin";
      mainProgram = "ols";
      homepage = "https://github.com/DanielGavin/ols";
      license = licenses.mit;
      maintainers = with maintainers; [ spitulax ];
    };
  }
)
