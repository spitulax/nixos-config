{ lib
, gitHubPkg
, stdenv
}:
let
  rtpPath = "share/tmux-plugins";

  addRtp =
    path: rtpFilePath: attrs: derivation:
    derivation
    // {
      rtp = "${derivation}/${path}/${rtpFilePath}";
    }
    // {
      overrideAttrs = f: mkTmuxPlugin (attrs // (if lib.isFunction f then f attrs else f));
    };

  mkTmuxPlugin =
    a@{ pluginName
    , rtpFilePath ? (builtins.replaceStrings [ "-" ] [ "_" ] pluginName) + ".tmux"
    , namePrefix ? "tmuxplugin-"
    , src
    , unpackPhase ? ""
    , configurePhase ? ":"
    , buildPhase ? ":"
    , addonInfo ? null
    , preInstall ? ""
    , postInstall ? ""
    , path ? lib.getName pluginName
    , ...
    }:
    if lib.hasAttr "dependencies" a then
      throw "dependencies attribute is obselete. see NixOS/nixpkgs#118034" # added 2021-04-01
    else
      addRtp "${rtpPath}/${path}" rtpFilePath a (
        stdenv.mkDerivation (
          a
          // {
            pname = namePrefix + pluginName;

            inherit
              pluginName
              unpackPhase
              configurePhase
              buildPhase
              addonInfo
              preInstall
              postInstall
              ;

            installPhase = ''
              runHook preInstall

              target=$out/${rtpPath}/${path}
              mkdir -p $out/${rtpPath}
              cp -r . $target
              if [ -n "$addonInfo" ]; then
                echo "$addonInfo" > $target/addon-info.json
              fi

              runHook postInstall
            '';
          }
        )
      );

  pkg = gitHubPkg {
    owner = "rose-pine";
    repo = "tmux";
    ref = "main";
    dirname = "rose-pine-tmux";
  };
in
mkTmuxPlugin (pkg // {
  pluginName = "rose-pine";
  rtpFilePath = "rose-pine.tmux";
  meta = {
    homepage = "https://github.com/rose-pine/tmux";
    description = "Rosé Pine theme for tmux";
    license = lib.licenses.mit;
  };
})
