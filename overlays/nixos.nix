{ inputs
, pkgs
, ...
}:
let
  nix-gaming-pkgs = inputs.nix-gaming.packages.${pkgs.system};
in
{
  steam = _: prev: {
    steam = prev.steam.override {
      extraProfile = "export STEAM_EXTRA_COMPAT_TOOLS_PATHS='${nix-gaming-pkgs.proton-ge}'";
    };
  };
}
