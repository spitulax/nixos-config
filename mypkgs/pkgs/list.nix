{ callPackage
, getByName
, getByName'
, myLib
, ...
}:
let
  inherit (myLib.drv)
    uncache
    ignore
    ;
in
rec {
  # KEEP THE LIST ALPHABETICALLY SORTED!
  crt = getByName' "crt";
  gplates = uncache (callPackage ./gplates { });
  gripper = getByName "gripper";
  hunspell-id = callPackage ./hunspell-id { };
  lexurgy = callPackage ./lexurgy { };
  mcpelauncher-client = callPackage ./mcpelauncher-client { };
  mcpelauncher-ui-qt = callPackage ./mcpelauncher-ui-qt { inherit mcpelauncher-client; };
  odin = ignore (callPackage ./odin { });
  odin-doc = ignore (callPackage ./odin-doc { odin = odin-git; });
  odin-git = ignore (callPackage ./odin-git { });
  odin-nightly = ignore (callPackage ./odin-nightly { });
  ols = ignore (callPackage ./ols { odin = odin-git; });
  osu-lazer = ignore (callPackage ./osu-lazer { });
  pasteme = getByName "pasteme";
  rose-pine-tmux = callPackage ./rose-pine-tmux { };
  whitesur-cursors = callPackage ./whitesur-cursors { };
}
