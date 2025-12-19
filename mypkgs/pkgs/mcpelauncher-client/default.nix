{ mcpelauncher-client
, gitHubPkg
, lib
}:
let
  src = gitHubPkg {
    owner = "minecraft-linux";
    repo = "mcpelauncher-manifest";
    dirname = "mcpelauncher-client";
    submodules = true;
  };
in
mcpelauncher-client.overrideAttrs (_: prevAttrs: src // {
  cmakeFlags = prevAttrs.cmakeFlags ++ [
    (lib.cmakeFeature "CMAKE_POLICY_VERSION_MINIMUM" "3.5")
  ];
})
