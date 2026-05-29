{ mcpelauncher-client
, gitHubPkg
, qt6
, lib
}:
let
  src = gitHubPkg {
    owner = "minecraft-linux";
    repo = "mcpelauncher-manifest";
    dirname = "mcpelauncher-client";
    ref = "qt6";
    submodules = true;
  };
in
mcpelauncher-client.overrideAttrs (_: prevAttrs: src // {
  patches = lib.lists.replaceElemAt prevAttrs.patches 0 ./dont_download_glfw_client.patch;
  cmakeFlags = prevAttrs.cmakeFlags ++ [
    (lib.cmakeFeature "CMAKE_POLICY_VERSION_MINIMUM" "3.5")
  ];
})
