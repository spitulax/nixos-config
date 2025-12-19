{ mcpelauncher-client
, mcpelauncher-ui-qt
, gitHubPkg
}:
let
  src = gitHubPkg {
    owner = "minecraft-linux";
    repo = "mcpelauncher-ui-manifest";
    dirname = "mcpelauncher-ui-qt";
    submodules = true;
  };
in
(mcpelauncher-ui-qt.override { inherit mcpelauncher-client; }).overrideAttrs (_: _: src)
