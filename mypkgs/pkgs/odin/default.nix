{ myLib
, lib
, gitHubReleasePkg
, callPackage
, mkPkg
  # , archiveTools
}:
let
  pkg' = gitHubReleasePkg {
    owner = "odin-lang";
    repo = "odin";
    assetName = "odin-linux-amd64-%V.zip";
    useReleaseName = true;
    prefixVersion = true;
  };
  inherit (pkg') version;
  inherit (pkg'.passthru) dirname;
  updateScript = pkg'.passthru.mypkgsUpdateScript;
in
callPackage myLib.helpers.odinDerivation {
  pname = "odin";
  pkg =
    let
      url = (myLib.getPkgData dirname).url;
      dir = lib.elemAt
        (lib.splitString
          "."
          (lib.last
            (lib.splitString "/" url)))
        0;
    in
    mkPkg {
      inherit version dirname updateScript;
      # For some unknown reason, inside the .zip file there are 2 directories
      src = "${pkg'.src}/${dir}";
    };
}
# Not needed now
# callPackage myLib.helpers.odinDerivation {
#   pname = "odin";
#   pkg = mkPkg {
#     inherit version dirname updateScript;
#     # For some unknown reason, inside the .zip file is another archive (.tar.gz) file
#     src = archiveTools.extractTarGz {
#       inherit (pkg') src;
#       flatten = true;
#     };
#   };
# }
