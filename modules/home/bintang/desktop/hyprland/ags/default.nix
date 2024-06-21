{ inputs
, pkgs
, config
, ...
}: {
  imports = [
    inputs.ags.homeManagerModules.default
  ];

  programs.ags = {
    enable = true;
    package = pkgs.mypkgs.ags;
    configDir = ./config;
  };

  xdg.dataFile."ags/types" = {
    source = "${config.programs.ags.finalPackage}/share/com.github.Aylur.ags/types";
    recursive = true;
  };
}
