{ pkgs
, config
, ...
}:
let
  emacs = with pkgs; (emacsPackagesFor emacs-unstable-pgtk).emacsWithPackages
    (epkgs: [ ]);
in
{
  home.packages = with pkgs; [
    coreutils
    emacs
  ];

  home.sessionPath = [
    "${config.xdg.configHome}/emacs/bin"
  ];

  services.emacs = {
    enable = true;
    package = emacs;
  };
}
