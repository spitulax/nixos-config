{ config
, lib
, pkgs
, ...
}:
let
  cfg = config.configs.apps.distrobox;

  inherit (pkgs) distrobox;

  # Fix distrobox environment with `exec distrobox-env {container-name}`
  distrobox-env = pkgs.writeShellScriptBin "distrobox-env" ''
    set -euo pipefail

    [ $# -lt 2 ] && echo "<name> <shell> must be supplied" 1>&2 && exit 1

    PROFILE=''${1:-default}
    SH=''${2:-sh}

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

    exec $SH
  '';

  distrobox-enter = pkgs.writeShellScriptBin "distrobox-enter" ''
    set -euo pipefail

    [ $# -lt 1 ] && echo "<name> must be supplied" 1>&2 && exit 1
    NAME=$1
    shift
    ${distrobox}/bin/distrobox-enter --name "$NAME" $@ -- ${lib.getExe distrobox-env} "$NAME" "$(${pkgs.coreutils}/bin/basename "$SHELL")"
  '';
in
{
  options.configs.apps.distrobox.enable = lib.mkEnableOption "Distrobox.\nNeeds {option}`nixos.docker.enable`";

  config = lib.mkIf cfg.enable {
    home.packages = [
      distrobox
      (lib.hiPrio distrobox-enter)
      distrobox-env
    ];
  };
}
