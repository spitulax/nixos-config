# Keys

## SSH

### NixOS Config

A pair of SSH public keys (rsa and ed25519) are needed if `config.configs.openssh.addHostKeys` is
`true`. The rsa key should be password protected, the ed25519 key should not. Put the public keys at
`/keys/hosts/<hostname>/ssh-rsa.pub` and `/keys/hosts/<hostname>/ssh-ed25519.pub`.

### Home Manager Config

The user has both ed25519 and rsa keys. The rsa key should be password protected, the ed25519 key
should not. Put the public keys at `/keys/users/<username>/ssh-rsa.pub` and
`/keys/users/<username>/ssh-ed25519.pub`. This is mandatory.

## GPG

[This module](../config/home/common/gpg.nix) needs a public GPG key at
`/keys/users/<username>/gpg1.asc`.
