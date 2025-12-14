<h1 align="center">spitulax's Nix Packages</h1>

Collection of packages (derivations) for my needs. This also provides a way to
automate update for all packages declared here.

The [original mypkgs](https://github.com/spitulax/mypkgs) is discontinued in
favor of integrating it inside my config repo. This mypkgs only provides
derivations and not binaries. Caching is also removed.

<h2 align="center">List of Packages and Flakes</h2>

See [here](./list.md).

# Usage

## Adding a Package

<!-- DOCS: Finish this, and also refactor utils -->

Create a directory within [`pkgs/`](./pkgs/) and a `default.nix` file inside the
directory that will house the derivation file for the package. Simply declare
the derivation using the usual Nix function (e.g. `stdenv.mkDerivation`). But to
utilize the auto-update feature, grab the source of the program using one of the
function declared in ``
