{ pkgs
, utils
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

  inherit (utils)
    getFlake
    getFlakePackages
    getFlakePackages'
    ;

  inherit (myLib)
    mkDate
    drv
    mkLongVersion
    ;

  # If the package name is the same as the input name
  getByName = name:
    let
      packages = getFlakePackages' name;
    in
    if builtins.hasAttr name packages
    then packages.${name}
    else packages.default;

  # Same as `getByName` but adds unique rev to version
  getByName' = name:
    let
      flake = getFlake name;
      packages = getFlakePackages flake;
      pkg =
        if builtins.hasAttr name packages
        then packages.${name}
        else packages.default;
    in
    pkg.overrideAttrs (_: prevAttrs: {
      __intentionallyOverridingVersion = true;
      version = mkLongVersion flake prevAttrs.version;
    });

  scope = makeScope pkgs.newScope
    (self: {
      inherit myLib utils getByName getByName';
      inherit (self) system;
    } // utils);

  updateScripts = packages:
    let
      scripts = mapAttrs'
        (_: v: nameValuePair v.passthru.dirname v.passthru.mypkgsUpdateScript)
        (filterAttrs
          (_: v: v.passthru ? mypkgsUpdateScript && v.passthru.mypkgsUpdateScript != null)
          packages);
    in
    runCommand
      "mypkgs-pkgs-update-scripts"
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
  # Before adding packages from a flake, make sure the flake.json file for the flake already exists.
  packages = import ./list.nix scope;

  update-scripts = updateScripts (drv.maintained packages);
  update-scripts-all = updateScripts packages;
}
