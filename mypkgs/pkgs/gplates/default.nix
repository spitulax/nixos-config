{ gplates
, makeDesktopItem
, fetchurl
, utils
, symlinkJoin
, runCommand
, makeBinaryWrapper
}:
let
  iconDrv = utils.archiveTools.extractZip {
    src = fetchurl {
      # Update scripts?
      # This should not change THAT frequently
      url = "https://www.earthbyte.org/webdav/ftp/earthbyte/GPlates_logo.zip";
      hash = "sha256-xgExVQFw3IKDHaojwsoJuoC4Z5DjA3cuKZtmHfE1t9E=";
    };
  };

  desktopItem = makeDesktopItem {
    name = "gplates";
    desktopName = "GPlates";
    comment = "Plate tectonics program";
    exec = "${gplates-wrapped}/bin/gplates %U";
    icon = "${iconDrv}/newlogo.svg";
  };

  # Wayland fix
  # https://discourse.gplates.org/t/release-gplates-as-snap-or-flatpak-for-linux/696/2?u=john.cannon
  gplates-wrapped = runCommand gplates.name
    {
      inherit (gplates) pname version meta;
      nativeBuildInputs = [ makeBinaryWrapper ];
    }
    ''
      mkdir -p $out
      cp -r ${gplates}/share $out/share
      mkdir -p $out/bin
      cp ${gplates}/bin/.gplates-wrapped $out/bin
      cp ${gplates}/bin/gplates $out/bin/.gplates-wrapped-1
      makeBinaryWrapper $out/bin/.gplates-wrapped-1 $out/bin/gplates \
        --set QT_QPA_PLATFORM xcb
    '';
in
symlinkJoin {
  pname = "gplates";
  inherit (gplates) version meta;
  paths = [
    gplates-wrapped
    desktopItem
  ];
}
