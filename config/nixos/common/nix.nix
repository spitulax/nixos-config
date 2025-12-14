{ config
, pkgs
, lib
, ...
}:
let
  cleanScript = pkgs.writeShellScriptBin "clean" ''
    set -euo pipefail

    OLDER_THAN=''${1:-3d}
    if [ "$OLDER_THAN" == "all" ]; then
        FLAGS=""
    else
        FLAGS="--older-than $OLDER_THAN"
    fi

    findResult () {
        fd -t l --hidden --no-ignore --case-sensitive '^result(-.+)?$' $@
    }

    echo "Run this script after rebooting for the best result."
    sudo echo

    printf "\033[1;31mPress ENTER to delete \`result\` links...\n"
    printf "\033[0m"
    read
    for i in $(findResult "$HOME" && findResult $(fd -t d '^nh-.*$' /tmp)); do
        echo "Deleting $i"
        sudo unlink $i
    done
    echo

    printf "\033[1;31mPress ENTER to delete home-manager profiles...\n"
    printf "\033[0m"
    read
    nix profile wipe-history --debug $FLAGS --profile $XDG_STATE_HOME/nix/profiles/home-manager
    echo

    printf "\033[1;31mPress ENTER to delete user profiles...\n"
    printf "\033[0m"
    read
    nix profile wipe-history --debug $FLAGS --profile $XDG_STATE_HOME/nix/profiles/profile
    echo

    printf "\033[1;31mPress ENTER to delete system profiles...\n"
    printf "\033[0m"
    read
    sudo nix profile wipe-history --debug $FLAGS --profile /nix/var/nix/profiles/system
    echo

    printf "\033[1;31mPress ENTER to run nix store gc...\n"
    printf "\033[0m"
    read
    sudo nix store gc --debug
    echo
  '';
in
{
  # Put this flake (as self) and its inputs in the nix registry
  # nix.registry =
  #   lib.mapAttrs
  #     (_: flake: { inherit flake; })
  #     (lib.filterAttrs
  #       (_: lib.isType "flake")
  #       inputs);

  # Put symlink to nix flake registries to /etc/nix/path
  # environment.etc =
  #   lib.mapAttrs'
  #     (name: value: {
  #       name = "nix/path/${name}";
  #       value.source = value.flake;
  #     })
  #     config.nix.registry;

  # Put the flakes in the registry to NIX_PATH so they can be accessed with angular brackets (<>) like channels
  # nix.nixPath just sets the NIX_PATH environment variable but it doesn't work due to a pesky bug https://github.com/NixOS/nix/issues/9574
  # nix.nixPath =
  #   map
  #     (x: "${x}=/etc/nix/path/${x}")
  #     (builtins.attrNames config.nix.registry);

  nix = {
    package = lib.mkDefault pkgs.nix;
    settings = {
      inherit (pkgs.myArgs.vars) substituters trusted-public-keys;
      auto-optimise-store = true;
      experimental-features = [ "nix-command" "flakes" ];
      warn-dirty = false;
      trusted-users = [ "root" "@wheel" ];
      nix-path = config.nix.nixPath; # This is a working alternative to nix.nixPath
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than +3";
    };
  };

  environment.systemPackages = [
    cleanScript
  ];
}
