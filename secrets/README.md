# How the secrets are managed

Setting up sops was an unbearable pain. I wrote this so I wouldn't need to experience it again.

The secret .yaml files are located [here] and categorised by the user of the secrets.

## .sops.yaml

All hosts and users must have their age key fingerprint listed in [.sops.yaml]. When adding a
directory to [here] also update [.sops.yaml].

## NixOS module config

NixOS sops config is located [here](../config/nixos/sops.nix). Each host expects a default sops file
which is `../secrets/hosts/<hostname>/secrets.yaml`, create it for each host.

The age key is located in `/var/lib/age/host.txt` with ownership of `root:wheel` and `640`
permission so `@wheel` users can access it without `sudo` (important for `nh`). The age key should
be generated with `ssh-to-age -private-key -i /etc/ssh/ssh-ed25519 > /var/lib/age/host.txt` and make
sure the ssh key is not password protected. `config.sops.age.sshKeyPaths` and
`config.sops.gnupg.sshKeyPaths` should be empty.

## Home Manager config

Home Manager sops config is located in `../modules/home/<username>/sops.nix`. Each user also expects
a default sops file which is `../secrets/users/<username>/secrets.yaml`, create it for each user.

The age key is located in `$XDG_DATA_HOME/age/user.txt` with `600` permission. The age key should be
generated with `ssh-to-age -private-key -i ~/.ssh/id_ed25519 > $XDG_DATA_HOME/age/user.txt` and also
make sure the ssh key is not password protected. `config.sops.age.sshKeyPaths` should be empty.

[here]: ../secrets
[.sops.yaml]: ../.sops.yaml
