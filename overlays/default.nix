{ inputs
, ...
}: {
  # Add custom packages
  # This is where packages from ../packages are added to pkgs
  add = final: _: import ../packages { pkgs = final; };

  # Modify packages from nixpkgs
  modify = final: prev: {
    # spotdl is supposed to use ffmpeg 4
    # otherwise downloading large albums will make it stuck
    # https://github.com/spotDL/spotify-downloader/blob/v4.2.5/spotdl/utils/ffmpeg.py#L37
    spotdl = prev.spotdl.override { ffmpeg = final.ffmpeg_4; };

    waybar = prev.waybar.overrideAttrs (newAttrs: oldAttrs: {
      version = "0.10.1";
      src = final.fetchFromGitHub {
        owner = "Alexays";
        repo = "Waybar";
        rev = newAttrs.version;
        hash = "sha256-fmmYoOnBVJKvnrF3S95pftmBECaufhe40g5Qcdz9A08=";
      };
      buildInputs = (builtins.filter (p: p.pname != "wireplumber") oldAttrs.buildInputs) ++ [
        prev.wireplumber
      ];
    });
  };
}
