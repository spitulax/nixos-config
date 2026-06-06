# Taken from https://github.com/fufexan/nix-gaming/blob/master/pkgs/osu-lazer-bin/default.nix
{ lib
, appimageTools
, fetchurl
, makeWrapper
, symlinkJoin
, gamemode
, gitHubReleasePkg
, makeDesktopItem
, stdenvNoCC
, fetchgit
, librsvg
, imagemagick

, pipewire_latency ? "64/44100"
, gmrun_enable ? true
, command_prefix ? if
    gmrun_enable
  then
    "${gamemode}/bin/gamemoderun"
  else
    null
, releaseStream ? "lazer"
}:
let
  pname = "osu-lazer-bin";

  pkg = gitHubReleasePkg {
    owner = "ppy";
    repo = "osu";
    assetName = "osu.AppImage";
    dirname = "osu-lazer";
  };
  inherit (pkg) version;

  derivation = appimageTools.wrapType2 {
    inherit version pname;
    inherit (pkg) src;

    extraPkgs = pkgs: [ pkgs.icu ];

    extraInstallCommands =
      let
        contents = appimageTools.extract { inherit pname version; inherit (pkg) src; };
      in
      ''
        . ${makeWrapper}/nix-support/setup-hook
        mv -v $out/bin/${pname} $out/bin/osu!

        wrapProgram $out/bin/osu! \
          --set PIPEWIRE_LATENCY "${pipewire_latency}" \
          --set OSU_EXTERNAL_UPDATE_PROVIDER "1" \
          --set OSU_EXTERNAL_UPDATE_STREAM "${releaseStream}" \
          --set vblank_mode "0"

        ${
          # a hack to infiltrate the command in the wrapper
          lib.optionalString (builtins.isString command_prefix) ''
            sed -i '$s:exec -a "$0":exec ${command_prefix}:' $out/bin/osu!
          ''
        }

        install -m 444 -D ${contents}/osu!.desktop $out/share/applications/osu-lazer.desktop
        for i in 16 32 48 64 96 128 256 512 1024; do
          install -D ${contents}/osu.png $out/share/icons/hicolor/''${i}x$i/apps/osu.png
        done
      '';
  };

  desktopItem = makeDesktopItem {
    name = "osu-lazer";
    exec = "${derivation.outPath}/bin/osu-lazer %U";
    icon = "${derivation.outPath}/osu.png";
    comment = "A free-to-win rhythm game. Rhythm is just a *click* away!";
    desktopName = "osu!";
    categories = [ "Game" ];
    mimeTypes = [
      "application/x-osu-skin-archive"
      "application/x-osu-replay"
      "application/x-osu-beatmap-archive"
      "x-scheme-handler/osu"
    ];
  };

  # Taken from https://github.com/fufexan/nix-gaming/blob/master/pkgs/osu-mime/default.nix
  mime =
    let
      osu-web-rev = "96e384d5932c0113d1ad8fa8c6ac1052d1e22268";
      osu-mime-spec-rev = "a715a74c2188297e61ac629abaed27fa56f0538c";
    in
    stdenvNoCC.mkDerivation {
      pname = "osu-mime";
      version = "unstable-2023-05-31";

      srcs = [
        (fetchurl {
          url = "https://raw.githubusercontent.com/ppy/osu-web/${osu-web-rev}/public/images/layout/osu-logo-triangles.svg";
          sha256 = "4a6vm4H6iOmysy1/fDV6PyfIjfd1/BnB5LZa3Z2noa8=";
        })
        (fetchurl {
          url = "https://raw.githubusercontent.com/ppy/osu-web/${osu-web-rev}/public/images/layout/osu-logo-white.svg";
          sha256 = "XvYBIGyvTTfMAozMP9gmr3uYEJaMcvMaIzwO7ZILrkY=";
        })
        (fetchgit {
          url = "https://aur.archlinux.org/osu-mime";
          rev = osu-mime-spec-rev;
          sha256 = "sha256-Ef/nApqNOD8mMqTxb0XV6oxgaYGweWsy9zUalgHruDM=";
        })
      ];

      nativeBuildInputs = [
        librsvg
        imagemagick
      ];

      dontUnpack = true;

      installPhase = ''
        # Turn $srcs into a bash array
        read -ra srcs <<< "$srcs"

        mime_dir="$out/share/mime/packages"
        hicolor_dir="$out/share/icons/hicolor"

        mkdir -p "$mime_dir" "$hicolor_dir"

        # Generate icons
        # Adapted from https://aur.archlinux.org/cgit/aur.git/tree/PKGBUILD?h=osu-mime
        for size in 16 24 32 48 64 96 128 192 256 384 512 1024; do
            icon_dir="$hicolor_dir/''${size}x''${size}/apps"

            # Generate icon
            rsvg-convert -w "$size" -h "$size" -f png -o "osu-logo-triangles.png" "''${srcs[0]}"
            rsvg-convert -w "$size" -h "$size" -f png -o "osu-logo-white.png" "''${srcs[1]}"
            convert -composite "osu-logo-triangles.png" "osu-logo-white.png" -gravity center 'osu!.png'

            mkdir -p "$icon_dir"
            mv 'osu!.png' "$icon_dir"
        done

        cp "''${srcs[2]}/osu-file-extensions.xml" "$mime_dir/osu.xml"
      '';
    };
in
symlinkJoin {
  pname = "osu-lazer";
  inherit version;
  paths = [
    derivation
    desktopItem
    mime
  ];

  inherit (pkg) passthru;

  meta = {
    description = "Rhythm is just a *click* away";
    longDescription = "osu-lazer extracted from the official AppImage to retain multiplayer support.";
    homepage = "https://osu.ppy.sh";
    license = with lib.licenses; [
      mit
      cc-by-nc-40
      unfreeRedistributable # osu-framework contains libbass.so in repository
    ];
    mainProgram = "osu-lazer";
    platforms = [ "x86_64-linux" ];
  };
}
