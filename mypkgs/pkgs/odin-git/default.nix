# Taken from https://github.com/NixOS/nixpkgs/blob/d70bd19e0a38ad4790d3913bf08fcbfc9eeca507/pkgs/by-name/od/odin/package.nix
{ gitHubPkg
, lib
, libiconv
, llvmPackages_latest
, darwin
, makeBinaryWrapper
, which
, odin

, llvmPackages ? llvmPackages_latest
}:
let
  inherit (llvmPackages) stdenv;
  inherit (darwin.apple_sdk_11_0) MacOSX-SDK;
  inherit (darwin.apple_sdk_11_0.frameworks) Security;

  pkg = gitHubPkg {
    owner = "odin-lang";
    repo = "Odin";
    ref = "master";
    dirname = "odin-git";
  };

  # TODO: Temporary patch, not needed after my PRs are merged
  patches = [
    ./linker.patch
    ./raylib-system.patch
  ];
in
stdenv.mkDerivation (pkg // {
  pname = "odin-git";

  inherit patches;

  postPatch =
    lib.optionalString stdenv.hostPlatform.isDarwin ''
      substituteInPlace src/linker.cpp \
          --replace-fail '/Library/Developer/CommandLineTools/SDKs/MacOSX.sdk' ${MacOSX-SDK}
    ''
    + ''
      substituteInPlace build_odin.sh \
          --replace-fail '-framework System' '-lSystem'
      patchShebangs build_odin.sh
    '';

  LLVM_CONFIG = "${llvmPackages.llvm.dev}/bin/llvm-config";

  dontConfigure = true;

  buildFlags = [ "release-native" ];

  nativeBuildInputs = [
    makeBinaryWrapper
    which
  ];

  buildInputs = lib.optionals stdenv.hostPlatform.isDarwin [
    libiconv
    Security
  ];

  preBuild = ''
    make -C vendor/cgltf/src
    make -C vendor/stb/src
    make -C vendor/miniaudio/src
  '';

  installPhase = ''
    runHook preInstall

    mkdir -p $out/bin
    mv odin $out/bin/odin

    mkdir -p $out/share
    mv base $out/share/base
    mv core $out/share/core
    mv vendor $out/share/vendor
    mv shared $out/share/shared

    wrapProgram $out/bin/odin \
      --prefix PATH : ${lib.makeBinPath (with llvmPackages; [
        bintools
        llvm
        clang
        lld
      ])} \
      --set-default ODIN_ROOT $out/share

    runHook postInstall
  '';

  meta = odin.meta // {
    maintainers = with lib.maintainers; [ spitulax ];
  };
})
