{ stdenvNoCC
, makeWrapper
, jre_minimal
, jdk
, lib
, gitHubReleasePkg
}:
let
  pkg = gitHubReleasePkg {
    owner = "def-gthill";
    repo = "lexurgy";
    assetName = "lexurgy-%v.tar";
  };
in
stdenvNoCC.mkDerivation (pkg // {
  pname = "lexurgy";

  nativeBuildInputs = [ makeWrapper ];
  buildInputs = [ jre_minimal ];

  dontConfigure = true;
  dontBuild = true;

  installPhase = ''
    mkdir -p $out
    mv * $out
    rm $out/bin/*.bat
    wrapProgram $out/bin/lexurgy \
      --set JAVA_HOME ${jre_minimal.home}
  '';

  meta = with lib; {
    inherit (jdk.meta) platforms;
    description = "A high-powered sound change applier";
    mainProgram = "lexurgy";
    homepage = "https://github.com/def-gthill/lexurgy";
    license = with licenses; [ gpl3Only ];
    maintainers = with maintainers; [ spitulax ];
  };
})
