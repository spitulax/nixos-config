# Taken from https://github.com/fufexan/nix-gaming/blob/master/pkgs/osu-lazer-bin/default.nix
{ lib
, gitHubReleasePkg
, appimageTools
, stdenvNoCC
, SDL2
, alsa-lib
, ffmpeg_4
, icu
, libkrb5
, lttng-ust
, numactl
, openssl
, vulkan-loader
, autoPatchelfHook
, makeWrapper
, gamemode
, makeDesktopItem
, symlinkJoin
, fetchurl
, librsvg
, imagemagick

, pipewireLatency ? "64/48000"
}:
let
  command_prefix = "${gamemode}/bin/gamemoderun";

  pkg = gitHubReleasePkg {
    owner = "ppy";
    repo = "osu";
    assetName = "osu.AppImage";
    dirname = "osu-lazer";
  };
  inherit (pkg) version;

  extracted = appimageTools.extract {
    inherit (pkg) version src;
    pname = "osu.AppImage";
  };

  derivation = stdenvNoCC.mkDerivation (finalAttrs: {
    pname = "osu-lazer";
    inherit version;
    src = extracted;
    buildInputs = [
      SDL2
      alsa-lib
      ffmpeg_4
      icu
      libkrb5
      lttng-ust
      numactl
      openssl
      vulkan-loader
    ];
    nativeBuildInputs = [
      autoPatchelfHook
      makeWrapper
    ];
    autoPatchelfIgnoreMissingDeps = true;
    installPhase = ''
      runHook preInstall
      install -d $out/bin $out/lib
      install osu.png $out/osu.png
      cp -r usr/bin $out/lib/osu
      makeWrapper $out/lib/osu/osu\! $out/bin/osu-lazer \
        --set COMPlus_GCGen0MaxBudget "600000" \
        --set PIPEWIRE_LATENCY "${pipewireLatency}" \
        --set OSU_EXTERNAL_UPDATE_PROVIDER "1" \
        --set vblank_mode "0" \
        --suffix LD_LIBRARY_PATH : "${lib.makeLibraryPath finalAttrs.buildInputs}"
      ${
        lib.optionalString (builtins.isString command_prefix) ''
          sed -i '$s:exec :exec ${command_prefix} :' $out/bin/osu-lazer
        ''
      }
      runHook postInstall
    '';
    fixupPhase = ''
      runHook preFixup
      ln -sft $out/lib/osu ${SDL2}/lib/libSDL2${stdenvNoCC.hostPlatform.extensions.sharedLibrary}
      runHook postFixup
    '';
  });

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
        (fetchurl {
          url = "https://aur.archlinux.org/cgit/aur.git/plain/osu-file-extensions.xml?h=osu-mime&id=${osu-mime-spec-rev}";
          sha256 = "MgQNW0RpnEYTC0ym6wB8cA6a8GCED1igsjOtHPXNZVo=";
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

        cp "''${srcs[2]}" "$mime_dir/osu.xml"
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
