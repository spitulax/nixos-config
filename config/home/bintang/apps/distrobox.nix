{ config
, lib
, pkgs
, ...
}:
let
  cfg = config.configs.apps.distrobox;

  # Fix distrobox environment with `exec distrobox-env {container-name}`
  distrobox-env = pkgs.writeShellScriptBin "distrobox-env" ''
    PROFILE=''${1:-default}

    if [ -d "$HOME/.local/bin/distrobox/$PROFILE" ]; then
      PATH="$HOME/.local/bin/distrobox/$PROFILE:$PATH"
    fi
    PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:$PATH"
    export PATH

    if [ -d "$HOME/.local/lib/distrobox/$PROFILE" ]; then
      LD_LIBRARY_PATH="$HOME/.local/lib/distrobox/$PROFILE:$LD_LIBRARY_PATH"
    fi
    LD_LIBRARY_PATH="/usr/local/lib:/usr/lib:/lib:$LD_LIBRARY_PATH"
    export LD_LIBRARY_PATH

    # Odin
    export ODIN_ROOT=$HOME/.local/share/distrobox/''${PROFILE}/odin

    exec $SHELL
  '';
in
{
  options.configs.apps.distrobox.enable = lib.mkEnableOption "Distrobox.\nNeeds {option}`nixos.docker.enable`";

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      distrobox
      boxbuddy
      distrobox-env
    ];
  };
}
