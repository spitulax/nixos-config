{ config
, lib
, ...
}: {
  config = lib.mkIf config.configs.desktop.enable {
    # this option used to be `hardware.opengl` if you're wondering why this file's name is `opengl.nix`
    hardware.graphics.enable = true;
  };
}
