{ config
, myLib
, lib
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
  imports = myLib.importIn ./.;

  options.configs = {
    extraPackages = mkOption {
      type = types.listOf types.package;
      default = [ ];
      description = "Extra packages to be included with system packages.";
    };

    hostName = mkOption {
      type = types.str;
      description = "The system's host name.";
    };

    requiredFiles = mkOption {
      type = with types; attrsOf (oneOf [ path (listOf path) (attrsOf path) ]);
      default = { };
      description = "List of files in this config required for the system to build.";
    };

    stateVersion = mkOption {
      type = types.str;
      default = "23.11";
      description = "Configuration state version.";
    };
  };

  config = {
    networking.hostName = cfg.hostName;
    system.stateVersion = cfg.stateVersion;
  };
}
