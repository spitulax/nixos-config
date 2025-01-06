{ lib # To use `homeManagerConfig` this must contain Home Manager's lib

  # For this flake only
, specialArgs ? { }
}: rec {
  /*
    Returns true if the given file has the given extension.

    Inputs:
      - `ext`: The extension to check for
      - `file`: The file's name

    Type: Path/String -> Bool
  */
  checkExt = ext: file:
    lib.last (builtins.split "\\.${ext}$" (builtins.toString file)) == "";

  /*
    Truncate the last extension in the given file name.

    Inputs:
      - `ext`: The extension to truncate
      - `file`: The file's name

    Type: Path/String -> Bool
  */
  truncateExt = ext: file:
    if checkExt ext file
    then builtins.head (builtins.split "\\.${ext}$" (builtins.toString file))
    else file;

  /*
    Returns a list of files in given directory.

    Inputs:
    - `dir`: The directory that contains the files
    - `types`: A list of included file types or pass [] if no files should be filtered. The possible values are "regular", "directory", "symlink" and "unknown"

    Type: Path -> [String] -> [String]
  */
  listFilesAll = dir: types:
    (builtins.attrNames
      (lib.filterAttrs
        (_: v: types == [ ] || builtins.elem v types)
        (builtins.readDir dir)));


  /*
    Wrappers to `listFilesAll` that only include either regular files or directories.

    Inputs:
      - `dir`: The directory that contains the files

    Type: Path -> [String]
  */
  listFiles = dir: listFilesAll dir [ "regular" ];
  listDirs = dir: listFilesAll dir [ "directory" ];


  /*
     Returns a list of regular files in given directory that have given extension.

    Inputs:
      - `dir`: The directory that contains the files
      - `ext`: The file extension (without leading period)

    Type: Path -> String -> [String]
  */
  listFilesExt = dir: ext:
    (builtins.filter
      (checkExt ext)
      (listFiles dir));


  /*
    Same as `listFilesExt` but with each file's extension removed.

    Inputs:
      - `dir`: The directory that contains the files
      - `ext`: The file extension (without leading period)

    Type: Path -> String -> [String]
  */
  listFilesExtTruncate = dir: ext:
    builtins.map
      (truncateExt ext)
      (listFilesExt dir ext);


  /*
    Generates an attribute set with each file in given directory as its name.

    Inputs:
      - `dir`: The directory that contains the files
      - `types`: A list of included file types or pass [] if no files should be filtered. The possible values are "regular", "directory", "symlink" and "unknown"
      - `f`: Function that takes the file name that generates the attribute's value

    Type: Path -> [String] -> (String -> Any) -> AttrSet
  */
  genAttrsEachFileAll = dir: types: f:
    lib.genAttrs
      (listFilesAll dir types)
      f;


  /*
    Wrappers to `genAttrsEachFile` that only include either regular files or directories.

    Inputs:
      - `dir`: The directory that contains the files
      - `f`: Function that takes the file name that generates the attribute's value

    Type: Path -> (String -> Any) -> AttrSet
  */
  genAttrsEachFile = dir: f: genAttrsEachFileAll dir [ "regular" ] f;
  genAttrsEachDir = dir: f: genAttrsEachFileAll dir [ "directory" ] f;


  /*
    This function is similar to `genAttrsEachFile` but it also includes files from subdirectories recursively.
    Directories are turned into an attrset of subdirectories or regular files.
    Regular files are turned into a string that represent a path relative to `dir`.

    Inputs:
      - `dir`: The topmost/starting directory
      - `f`: Function that takes the file path (relative to `dir`) that generates the attribute's value

    Type: Path -> (String -> Any) -> AttrSet
  */
  genAttrsEachFileRec = dir: f:
    let
      gen = dir: dirFunc: fileFunc:
        genAttrsEachDir dir dirFunc
        // genAttrsEachFile dir fileFunc;
      f' = prevn: n: f (prevn + "/" + n);
    in
    gen dir (n: genAttrsEachFileRec (lib.path.append dir n) (f' n)) f;


  /*
    A wrapper to `genAttrsEachFile` that only includes files that have given extension and remove the file extension in the attribute's name.

    Inputs:
      - `dir`: The directory that contains the files 
      - `ext`: The file extension (without leading period)
      - `f`: Function that takes the file name that generates the attribute's value

    Example:
      Given these files in `./.`: [ "README.md" "flake.nix" "flake.lock" "default.nix" ]
      ```
      genAttrsEachFileExt ./. "nix" lib.id
        => { flake = "flake.nix"; default = "default.nix"; }
      ```

    Type: Path -> String -> (String -> Any) -> AttrSet
  */
  genAttrsEachFileExt = dir: ext: f:
    let
      filterExt =
        lib.filterAttrs
          (n: _: checkExt ext n);
      truncateExt' =
        lib.mapAttrs'
          (n: lib.nameValuePair (truncateExt ext n));
    in
    truncateExt' (filterExt (genAttrsEachFile dir f));


  /*
    Same as `genAttrsEachFileRec` but only includes regular files that have given extension and remove the file extension in the attribute's name.
    If there is a regular file that has the same name as a directory after the extension has been stripped, the regular file takes precedence over the directory.

    Inputs:
      - `dir`: The topmost/starting directory
      - `ext`: The file extension (without leading period)
      - `f`: Function that takes the file path (relative to `dir`) that generates the attribute's value

    Type: Path -> String -> (String -> Any) -> AttrSet
  */
  genAttrsEachFileExtRec = dir: ext: f:
    let
      gen = dir: dirFunc: fileFunc:
        genAttrsEachDir dir dirFunc
        // genAttrsEachFileExt dir ext fileFunc;
      f' = prevn: n: f (prevn + "/" + n);
    in
    gen dir (n: genAttrsEachFileExtRec (lib.path.append dir n) ext (f' n)) f;


  /*
    Returns a list of paths that can be used to simplify module imports.
    Use this inside a `default.nix` file to import all nix files or directories containing nix files.

    Inputs:
      - `dir`: The directory that contains the files/directories to be imported

    Example:
      Given `./.`:
        | mod1/
        | mod2/
        | default.nix (current file)
        | other.nix
      ```
      importIn ./.
        => [ ./mod1 ./mod2 other.nix ]
      ```

    Type: Path -> [Path]
  */
  importIn = dir:
    let
      files = listFilesExt dir "nix" ++ listDirs dir;
    in
    builtins.map
      (lib.path.append dir)
      (builtins.filter (v: v != "default.nix") files);


  /*
        Generates an attribute set containing boolean module options.
        The description by default is "Whether to enable ${name}.".

        Inputs:
      - `names`: List of the options' name

        Type: [String] -> AttrSet
      */
  mkEnableOptions = names:
    mkEnableOptions' names (n: "Whether to enable ${n}.");


  /*
    Same as `mkEnableOptions` but the function for generating descriptions is specifiable.

    Inputs:
      - `names`: List of the options' name
      - `desc`: Function that takes an option's name and returns the description for it

    Type: [String] -> (String -> String) -> AttrSet
  */
  mkEnableOptions' = names: desc:
    lib.genAttrs
      names
      (n: lib.mkEnableOption "" // { description = desc n; });


  /*
    Takes an attribute set and remove the attribute that is null.

    Inputs:
    - `attrs`: Attribute set to be stripped

    Type: AttrSet -> AttrSet
  */
  stripAttrs = attrs:
    lib.filterAttrs (_: v: v != null) attrs;


  # TODO: need docs


  nixosConfig =
    { config
    , users ? [ ]
    , extraModules ? [ ]
    }:
    lib.nixosSystem {
      modules = [ config ] ++ (map (x: x.nixosModule) users) ++ extraModules;
      inherit specialArgs;
    };

  homeManagerConfig =
    { config
    , pkgs
    , extraModules ? [ ]
    }: lib.homeManagerConfiguration {
      inherit pkgs;
      modules = [ config ] ++ extraModules;
      extraSpecialArgs = specialArgs;
    };


  mkUser =
    { name
    , username
    , homeManager ? true
    , extraGroups ? [ ]
    , addSshKeys ? true # The user has both ed25519 and rsa keys. None sould be password protected.
    , addPassword ? true # The user has their password in the ${globalSecretsPath}/password.yaml
    , fishShell ? true
    }: rec {
      sshKeys = lib.optionals addSshKeys [
        ../keys/users/${username}/ssh-rsa.pub
        ../keys/users/${username}/ssh-ed25519.pub
      ];

      homeManagerConfigModule = ../config/home/${username};

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
        in
        {
          imports = [ homeManagerConfigModule ];

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
        }: {
          imports = lib.optionals homeManager [
            inputs.home-manager.nixosModules.default
          ];

          users.users.${username} = {
            isNormalUser = true;
            description = name;
            inherit extraGroups;
            shell = if fishShell then pkgs.fish else pkgs.bash;
            packages = lib.optionals homeManager [ pkgs.home-manager ];
            openssh.authorizedKeys.keyFiles = sshKeys;
            hashedPasswordFile = if addPassword then config.sops.secrets."password-${username}".path else null;
          };

          home-manager.users.${username} = lib.optionalAttrs homeManager (import ../users/${username}_${config.networking.hostName});
        } // lib.optionalAttrs addPassword {
          sops.secrets."password-${username}" = {
            neededForUsers = true;
            sopsFile = "${outputs.vars.globalSecretsPath}/password.yaml";
          };
        };
    };


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

}
