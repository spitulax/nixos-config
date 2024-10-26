{ inputs
, lib
, outputs
}: {
  # Add custom packages
  # This is where packages from ../packages are added to pkgs
  add = final: _: {
    custom = outputs.packages.${final.system};
    mypkgs = builtins.removeAttrs inputs.mypkgs.packages.${final.system} [ "all" ];
    # inputs.<flake>.packages|legacyPackages.<pkgs.system> -> pkgs.inputs.<flake>
    inputs =
      builtins.mapAttrs
        (
          _: flake:
            let
              legacyPackages = (flake.legacyPackages or { }).${final.system} or { };
              packages = (flake.packages or { }).${final.system} or { };
            in
            if legacyPackages != { }
            then legacyPackages
            else packages
        )
        inputs;

    # Nerdfonts
    iosevka-nerdfont = final.nerdfonts.override { fonts = [ "Iosevka" ]; };
    nerdfonts-symbols-only = final.nerdfonts.override { fonts = [ "NerdFontsSymbolsOnly" ]; };
  };

  # Modify packages from nixpkgs
  modify = final: prev: {
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

    # TEMP: https://github.com/NixOS/nixpkgs/issues/348819
    cliphist = prev.cliphist.overrideAttrs {
      src = final.fetchFromGitHub {
        owner = "sentriz";
        repo = "cliphist";
        rev = "c49dcd26168f704324d90d23b9381f39c30572bd";
        sha256 = "sha256-2mn55DeF8Yxq5jwQAjAcvZAwAg+pZ4BkEitP6S2N0HY=";
      };
      vendorHash = "sha256-M5n7/QWQ5POWE4hSCMa0+GOVhEDCOILYqkSYIGoy/l0=";
    };

    # TEMP: https://github.com/NixOS/nixpkgs/issues/348845
    inherit (outputs.tempPkgsFor.anki.${final.system}) anki;
  };

  # Compose existing overlays
  overlay =
    let
      overlays = with inputs; [
        rust-overlay.overlays.default
      ];
    in
    final: prev: prev.lib.composeManyExtensions overlays final prev;
}
