{ inputs
, lib
, myLib
, tempPkgsFor
, outputs
}@input:
let
  # Compose existing overlays
  compose = [
    inputs.mypkgs.overlays.default
    inputs.rust-overlay.overlays.default
  ];
in
{
  default =
    let
      addPhases =
        let
          phases = import ./add.nix input;
        in
        [
          phases.preAdd
          phases.addPhase
          phases.postAdd
        ];

      modifyPhases =
        let
          phases = import ./modify.nix input;
        in
        [
          phases.preModify
          phases.modifyPhase
          phases.postModify
        ];

      overlays = addPhases ++ modifyPhases ++ compose;
    in
    lib.composeManyExtensions overlays;
}
