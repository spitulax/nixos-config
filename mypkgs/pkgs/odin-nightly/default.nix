# WARNING: Retired code
{ lib
, myLib
, curl
, callPackage
, fetchzip
, writeShellScript
, gnused
, mkPkg
, exitIfNoNewVer
}:
let
  inherit (lib)
    toShellVar
    getExe
    ;

  inherit (myLib)
    getPkgData
    shell
    ;

  inherit (shell)
    echo
    ;

  importJSON = callPackage shell.importJSON { };
  serialiseJSON = callPackage shell.serialiseJSON { };
  getFileHash = callPackage shell.getFileHash { };

  dirname = "odin-nightly";
  pkgData = getPkgData dirname;
  inherit (pkgData) version;

  src = fetchzip {
    inherit (pkgData) url hash;
  };

  updateScript = writeShellScript "mypkgs-update-${dirname}" ''
    set -euo pipefail

    ${toShellVar "CURL" (getExe curl)}
    ${toShellVar "SED" (getExe gnused)}

    META=${importJSON "$($CURL -s 'https://odinbinaries.thisdrunkdane.io/file/odin-binaries/nightly.json')" ".files | to_entries | last | .value | .[0]"}
    VERSION=$(${echo (importJSON "$META" ".name")} | $SED -r 's/^.*\+(.*)\.tar\.gz$/\1/')
    ${exitIfNoNewVer "$VERSION"}
    URL=${importJSON "$META" ".url"}
    HASH=${getFileHash {url = "$URL"; archive = true;}}

    ${serialiseJSON {
      version = "$VERSION";
      orig_version = "$VERSION";
      url = "$URL";
      hash = "$HASH";
    }}
  '';
in
callPackage myLib.helpers.odinDerivation {
  pname = "odin-nightly";
  pkg = mkPkg {
    inherit src updateScript dirname version;
  };
}
