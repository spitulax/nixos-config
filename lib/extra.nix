{ lib
, specialArgs
, inputs
, outputs
, ...
}:
let
  commonHomeManagerModules = [
    ../config/home/common
  ];

  hmSpecialArgs = specialArgs // {
    hmLib = inputs.home-manager.lib;
  };
in
{
  /*
    Generates a NixOS system config.
    A pair of SSH public keys (rsa and ed25519) are needed if `config.configs.openssh.addHostKeys` is `true`.
    The rsa key should be password protected, the ed25519 key should not.
    Put the public keys at `/keys/hosts/<hostname>/ssh-rsa.pub` and `/keys/hosts/<hostname>/ssh-ed25519.pub`.

    The config module must be located in `/hosts/<hostname>/`.

    Type: AttrSet -> AttrSet
  */
  nixosConfig =
    {
      # AttrSet :: Nixpkgs instance to be used throughout the system.
      pkgs
      # String :: The system's hostname.
    , hostname
      # [AttrSet] :: The users in the system. Defined in `/flake/users.nix`.
    , users ? [ ]
      # [AttrSet] :: Extra config modules.
    , extraModules ? [ ]
    }:
    let
      config = ../hosts/${hostname};
    in
    lib.nixosSystem {
      modules = [
        outputs.nixosConfigModule
        inputs.home-manager.nixosModules.default

        {
          options.configs = with lib; {
            extraPackages = mkOption {
              type = types.listOf types.package;
              default = [ ];
              description = "Extra packages to be included with system packages.";
            };

            stateVersion = mkOption {
              type = types.str;
              default = "23.11";
              description = "Configuration state version.";
            };

            hostname = mkOption {
              type = types.str;
              default = hostname;
              readOnly = true;
              description = "The system's host name.";
            };
          };
        }

        {
          nixpkgs = {
            inherit pkgs;
          };
        }

        {
          home-manager = {
            extraSpecialArgs = hmSpecialArgs;
            sharedModules = commonHomeManagerModules;
            useGlobalPkgs = true;
          };
        }

        config
      ]
      ++ (map (x: x.nixosModule) users)
      ++ extraModules;
      specialArgs = specialArgs;
    };


  /*
    Generates a Home Manager config. One for each combination of users and host systems.

    The config module must be located in `/users/<username>_<hostname>/`.

    Type: AttrSet -> AttrSet
  */
  homeManagerConfig =
    {
      # AttrSet :: Nixpkgs instance to be used throughout the system.
      pkgs
      # String :: The username.
    , username
      # String :: The system's hostname.
    , hostname
    }:
    let
      config = ../users/${username}_${hostname};
    in
    inputs.home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      modules = [ config ]
        ++ commonHomeManagerModules;
      extraSpecialArgs = hmSpecialArgs;
    };

  /*
    Generates a user. The user is managed by Home Manager.

    The user has both ed25519 and rsa keys.
    The rsa key should be password protected, the ed25519 key should not.
    Put the public keys at `/keys/users/<username>/ssh-rsa.pub` and `/keys/users/<username>/ssh-ed25519.pub`.
    This is mandatory.

    The user has their password in `/secrets/global/password.yaml`.

    Used in `/flake/users`.

    Type: AttrSet -> AttrSet
  */
  mkUser =
    {
      # String :: The user's name or description.
      name
      # String :: The username.
    , username
      # [String] :: Groups the user is part of.
    , extraGroups ? [ ]
      # Bool: Use fish instead of bash as the default shell.
    , fishShell ? true
    }: rec {
      sshKeys = [
        ../keys/users/${username}/ssh-rsa.pub
        ../keys/users/${username}/ssh-ed25519.pub
      ];

      /*
        The module may be defined in `/config/home/<username>` for this specific user.
        The module imports `/config/home/common` so even though there's no module
        defined specifically for this user, it still contains the common module.
      */
      homeManagerModule =
        { config
        , pkgs
        , ...
        }:
        let
          inherit (lib)
            mkOption
            types
            ;

          cfg = config.configs;

          homeManagerConfigModule = ../config/home/${username};
        in
        {
          imports = lib.optionals
            (lib.pathExists homeManagerConfigModule) [
            homeManagerConfigModule
          ];

          options.configs = {
            extraPackages = mkOption {
              type = types.listOf types.package;
              default = [ ];
              description = "Extra packages to be included with user profile.";
            };

            defaultShell = mkOption {
              readOnly = true;
              type = types.package;
              default = if fishShell then pkgs.fish else pkgs.bash;
              description = "The user's default shell. Do not change this in home manager config.";
            };

            stateVersion = mkOption {
              type = types.str;
              default = "23.11";
              description = "Configuration state version.";
            };
          };

          config = {
            home = {
              inherit username;
              inherit (cfg) stateVersion;
              homeDirectory = "/home/${config.home.username}";
              packages = cfg.extraPackages;
            };

            programs.home-manager.enable = true;
          };
        };

      /*
        The module that would be imported to a NixOS system that has this user.
        The module defines necessary configuration to add the user to the system.
      */
      nixosModule =
        { config
        , pkgs
        , ...
        }:
        let
          inherit (config.configs) hostname;
        in
        {
          assertions = [{
            assertion = config.configs.sops.enable;
            message = "`configs.sops.enable` must be true to use user password";
          }];

          users.users.${username} = {
            isNormalUser = true;
            description = name;
            inherit extraGroups;
            shell = if fishShell then pkgs.fish else pkgs.bash;
            packages = [ pkgs.home-manager ];
            openssh.authorizedKeys.keyFiles = sshKeys;
            hashedPasswordFile = config.sops.secrets."password-${username}".path;
          };

          home-manager.users.${username} = import (../users + "/${username}_${hostname}");

          sops.secrets."password-${username}" = {
            neededForUsers = true;
            sopsFile = "${outputs.vars.globalSecretsPath}/password.yaml";
          };
        };
    };
}
