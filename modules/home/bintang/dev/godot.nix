{ pkgs
, ...
}: {
  home.packages = with pkgs; [
    godot_4
    gdtoolkit_4
  ];
}
