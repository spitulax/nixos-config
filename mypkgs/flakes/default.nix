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

  scope = makeScope pkgs.newScope
    (self: {
      inherit myLib utils;
      inherit (self) system;
    } // utils);

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

  listMaintainedScripts = flakes:
    let
      scripts = mapAttrs'
        (_: v: nameValuePair v.dirname v.updateScript)
        (filterAttrs
          (_: v: v ? updateScript && v.updateScript != null)
          flakes);
    in
    runCommand
      "mypkgs-flakes-list-maintained-scripts"
      { }
      ''
        touch $out
        ${toShellVar "SCRIPTS" scripts}
        for name in "''${!SCRIPTS[@]}"; do
          echo "$name" >> $out
        done
      '';
in
rec {
  flakes = import ./list.nix scope;

  update-scripts = updateScripts (myLib.drv.updateable flakes);
  list-maintained-scripts = listMaintainedScripts (myLib.drv.maintained flakes);
}
