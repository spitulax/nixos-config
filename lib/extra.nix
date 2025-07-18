{ lib
, specialArgs
, inputs
, ...
}: {
  nixosConfig =
    { config
    , hostName
    , pkgs
    , users ? [ ]
    , extraModules ? [ ]
    }:
    lib.nixosSystem {
      modules = [
        {
          nixpkgs = {
            inherit pkgs;
          };
        }
        config
      ] ++ (map (x: x.nixosModule) users) ++ extraModules;
      specialArgs = specialArgs // {
        inherit hostName;
      };
    };


  homeManagerConfig =
    { config
    , pkgs
    , extraModules ? [ ]
    }: inputs.home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      modules = [ config ] ++ extraModules;
      extraSpecialArgs = specialArgs;
    };

  # The user has both ed25519 and rsa keys. The rsa key should be password protected, the ed25519 key should not.
  # The user has their password in the ${globalSecretsPath}/password.yaml.
  mkUser =
    { name
    , username
    , extraGroups ? [ ]
    , fishShell ? true
    }: rec {
      sshKeys = [
        ../keys/users/${username}/ssh-rsa.pub
        ../keys/users/${username}/ssh-ed25519.pub
      ];

      homeManagerModule =
        { config
        , myLib
        , lib
        , outputs
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

          imports = [
            ../config/home/common
          ] ++ lib.optionals
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

            nixpkgs = {
              inherit (outputs.pkgsFor.x86_64-linux) config overlays;
            };

            systemd.user.startServices = "sd-switch";
            programs.home-manager.enable = true;
          };
        };

      nixosModule =
        { config
        , pkgs
        , inputs
        , lib
        , outputs
        , ...
        }:
        let
          hostname = config.configs.hostName;
        in
        {
          imports = [
            inputs.home-manager.nixosModules.default
          ];

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

          home-manager = {
            users.${username} = import (../users + "/${username}_${hostname}");
            extraSpecialArgs = specialArgs;
          };

          sops.secrets."password-${username}" = {
            neededForUsers = true;
            sopsFile = "${outputs.vars.globalSecretsPath}/password.yaml";
          };
        };
    };


  hmHelper = {
    mkAliasOptions =
      { desc
      , shells ? [ "fish" "bash" ]
      }:
      let
        option = name: {
          ${name} = lib.mkOption {
            type = lib.types.bool;
            default = false;
            description = "Whether to alias ${desc} in ${name}.";
          };
        };
      in
      lib.mergeAttrsList (map option shells);

    # Assign to `programs`.
    mkAliasConfig =
      { config
      , aliases
      , extraAliases ? { }
      }:
      lib.mergeAttrsList
        (lib.mapAttrsToList
          (k: v: {
            ${k}.shellAliases = lib.optionalAttrs v (aliases // extraAliases);
          })
          config);


    mkPkgsOptions =
      { desc ? lib.id
      , modules
      }:
      lib.mapAttrs
        (k: v: {
          enable = lib.mkEnableOption (desc v.desc) // {
            default = v.default or false;
          };
        })
        modules;

    # Assign to `home.packages`.
    mkPkgsConfig =
      { modules
      , cfg
      }: lib.flatten
        (lib.mapAttrsToList
          (_: v: v.pkgs)
          (lib.filterAttrs
            (_: v: v.enable)
            (lib.mapAttrs
              (k: v: {
                inherit (cfg.${k}) enable;
                inherit (v) pkgs;
              })
              modules)));
  };
}
