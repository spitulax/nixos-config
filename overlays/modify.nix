{ tempPkgsFor
, lib
, ...
}: {
  preModify = final: prev: { };

  # Modify packages from nixpkgs
  modifyPhase = final: prev: {
    # spotdl is supposed to use ffmpeg 4
    # otherwise downloading large albums will make it stuck
    # https://github.com/spotDL/spotify-downloader/blob/v4.2.5/spotdl/utils/ffmpeg.py#L37
    spotdl = prev.spotdl.override { ffmpeg = final.ffmpeg_4; };

    lutris = prev.lutris.override {
      steamSupport = false;
      extraPkgs = p: with p; [
        gamescope
        mangohud
        winetricks
      ];
    };

    cloudflare-warp = prev.cloudflare-warp.overrideAttrs (_: prevAttrs: {
      dontCopyDesktopItems = true;
      postInstall = ''
        ${prevAttrs.postInstall}
        rm -r $out/lib
        rm -r $out/share/applications
      '';
    });

    qgis = prev.qgis.override {
      extraPythonPackages = ps: with ps; [
        numpy
        matplotlib
      ];
    };
  };

  postModify = final: prev: { };
}
