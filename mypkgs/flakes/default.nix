{ utils
, pkgs
, myLib
}:
let
  inherit (pkgs)
    lib
    runCommand
    coreutils
    ;

  inherit (lib)
    makeScope
    callPackageWith
    mapAttrs'
    filterAttrs
    nameValuePair
    toShellVar
    ;

  scope = makeScope callPackageWith
    (self: {
      inherit myLib pkgs lib utils;
      inherit (self) callPackage;
      inherit (pkgs) system;
    } // pkgs // utils);

  updateScripts = flakes:
    let
      scripts = mapAttrs'
        (_: v: nameValuePair v.dirname v.updateScript)
        (filterAttrs
          (_: v: v ? updateScript && v.updateScript != null)
          flakes);
    in
    runCommand
      "mypkgs-flakes-update-scripts"
      { }
      ''
        mkdir -p $out
        ${toShellVar "SCRIPTS" scripts}
        for name in "''${!SCRIPTS[@]}"; do
          ${coreutils}/bin/ln -s ''${SCRIPTS[$name]} $out/$name
        done
      '';

in
rec {
  flakes = import ./list.nix scope;
  update-scripts = updateScripts (myLib.drv.maintained flakes);
}
