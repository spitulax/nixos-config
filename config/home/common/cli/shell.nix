{ config
, lib
, ...
}:
let
  inherit (lib)
    mkOption
    types
    genAttrs
    ;

  cfg = config.configs.cli.shellIntegrations;
in
{
  options.configs.cli.shellIntegrations = mkOption {
    type = types.either types.bool (types.listOf types.str);
    default = false;
    description = ''
      Whether to enable shell integration for given shells.
      If `true`, enable all shell integrations.
      If `false`, enable no shell integration.
      The names given must match {option}`home.shell.enable<NAME>Integration`.
    '';
  };

  config = {
    home.shell =
      if builtins.isBool cfg
      then {
        enableShellIntegration = cfg;
      }
      else
        genAttrs
          (map
            (x: "enable${x}Integration")
            cfg)
          (x: true)
        // {
          enableShellIntegration = false;
        }
    ;
  };
}
