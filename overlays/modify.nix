{ tempPkgsFor
, ...
}: {
  preModify = final: prev: {
    inputs = prev.inputs // {
      nix-gaming = prev.inputs.nix-gaming // {
        inherit (prev.inputs.nix-gaming-temp) wine-ge;
      };
    };
  };

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

    inherit (final.mypkgs)
      hyprlock
      hyprpaper
      hyprpicker
      hyprpolkitagent
      hyprswitch
      waybar
      whitesur-cursors
      gplates
      ;

    cloudflare-warp = prev.cloudflare-warp.overrideAttrs (_: prevAttrs: {
      dontCopyDesktopItems = true;
      postInstall = ''
        ${prevAttrs.postInstall}
        rm -r $out/lib
        rm -r $out/share/applications
      '';
    });
  };

  postModify = final: prev: { };
}
