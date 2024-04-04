{ inputs
, ...
}: {
  # Add custom packages
  # This is where packages from ../packages are added to pkgs
  add = final: _: import ../packages { pkgs = final; };

  # Modify packages from nixpkgs
  modify = final: prev: {
    brave = prev.brave.override {
      libvaSupport = true;
      enableVideoAcceleration = true;
    };

    # spotdl is supposed to use ffmpeg 4
    # https://github.com/spotDL/spotify-downloader/blob/v4.2.5/spotdl/utils/ffmpeg.py#L37
    spotdl = (prev.spotdl.override { ffmpeg = final.ffmpeg_4; }).overridePythonAttrs rec {
      version = "4.2.5";
      src = final.fetchFromGitHub {
        owner = "spotDL";
        repo = "spotify-downloader";
        rev = "v${version}";
        hash = "sha256-vxMhFs2mLbVQndlC2UpeDP+M4pwU9Y4cZHbZ8y3vWbI=";
      };
    };

    keymapper = prev.keymapper.overrideAttrs rec {
      version = "4.0.0";
      src = final.fetchFromGitHub {
        owner = "houmain";
        repo = "keymapper";
        rev = version;
        hash = "sha256-uMK8si0ATrpIesoWv7VavJQECFbB8qsck28VtkH3FY0=";
      };
    };
  };

  # For every flake input, aliases 'pkgs.inputs.${flake}' to
  # 'inputs.${flake}.packages.${pkgs.system}' or
  # 'inputs.${flake}.legacyPackages.${pkgs.system}'
  flake-inputs = final: _: {
    inputs = builtins.mapAttrs
      (_: flake:
        let
          legacyPackages = (flake.legacyPackages or { }).${final.system} or { };
          packages = (flake.packages or { }).${final.system} or { };
        in
        if legacyPackages != { } then legacyPackages else packages
      )
      inputs;
  };
}
