{ config
, lib
, pkgs
, ...
}:
with lib;
let
  cfg = config.services.keymapper;

  generateAliases = aliases:
    concatStringsSep "\n" (mapAttrsToList (n: v: n + " = " + v) aliases);

  generateConfig = settings:
    let
      genContextDefinition = context:
        "[" + pipe context [
          (mapAttrsToList
            (n: v:
              if hasPrefix "no" n && v != null
              then ''${removePrefix "no" n}!="${v}"''
              else if v != null
              then ''${n}="${v}"''
              else null))
          (filter (x: x != null))
          (concatStringsSep " ")
        ] + "]";

      genMappingDefinition = mappings:
        optionalString (mappings != [ ])
          (concatStringsSep "\n"
            (map (v: "${v.input} >> ${v.output}") mappings));

      contextDefinitions = map (x: genContextDefinition (removeAttrs x [ "mappings" ])) settings;
      mappingDefinitions = map (x: genMappingDefinition x.mappings) settings;
    in
    optionalString (settings != [ ])
      (concatStringsSep "\n\n"
        (zipListsWith
          (a: b:
            if a == "[]" then b
            else if b == "" then a
            else a + "\n" + b)
          contextDefinitions
          mappingDefinitions));

  mkContextOption = name: example: desc:
    {
      ${name} = mkOption {
        type = types.nullOr types.str;
        default = null;
        inherit example;
        description = desc + " where the mappings are enabled.";
      };
      "no${name}" = mkOption {
        type = types.nullOr types.str;
        default = null;
        visible = false;
      };
    };

  mappingModule = types.submodule {
    options = {
      input = mkOption {
        type = types.str;
        description = "Input expression of a mapping";
      };
      output = mkOption {
        type = types.str;
        description = "Output expression of a mapping";
      };
    };
  };

  contextModule = types.submodule {
    options = (foldAttrs mergeAttrs { } [
      (mkContextOption
        "system" # option name
        "Linux" # example
        "The system") # description
      (mkContextOption
        "title"
        "Chromium"
        "The focused window by title")
      (mkContextOption
        "class"
        "qtcreator"
        "The focused window by class name")
      (mkContextOption
        "path"
        "notepad.exe"
        "Process path")
      (mkContextOption
        "device"
        null
        "Input device an event originates from")
      (mkContextOption
        "device_id"
        null
        "Input device an event originates from")
      (mkContextOption
        "modifier"
        "Virtual1 !Virtual2"
        "State of one or more keys")
    ]) // {
      mappings = mkOption {
        type = types.listOf mappingModule;
        default = [ ];
        example = literalExpression ''
          [
            { input = "CapsLock"; output = "Backspace"; }
            { input = "Z"; output = "Y"; }
            { input = "Y"; output = "Z"; }
            { input = "Control{Q}"; output = "Alt{F4}"; }
          ]
        '';
        description = ''
          Declaration of mappings. The order of the list is reflected in the config file.
        '';
      };
    };
  };
in
{
  options.services.keymapper = {
    enable = mkEnableOption null // {
      description = ''
        Whether to enable keymapper, A cross-platform context-aware key remapper.

        ::: {.note}
        This module create a system service that runs the {command}`keymapper` binary.
        You have to enable {option}`services.keymapper` in NixOS to enable {command}`keymapperd`.
        Alternatively create the service yourself.
        :::
      '';
    };

    package = mkPackageOption pkgs "keymapper" { };

    aliases = mkOption {
      type = types.attrsOf types.str;
      default = { };
      example = literalExpression ''
        {
          Win = "Meta";
          Alt = "AltLeft | AltRight";
        }
      '';
      description = "Aliases of keys and/or sequences.";
    };

    contexts = mkOption {
      type = types.listOf contextModule;
      default = [ ];
      example = literalExpression ''
        [
          {
            mappings = [
              { input = "CapsLock"; output = "Backspace"; }
              { input = "Z"; output = "Y"; }
              { input = "Y"; output = "Z"; }
              { input = "Control{Q}"; output = "Alt{F4}"; }
            ];
          }
          {
            system = "Linux";
            noclass = "Thunar";
            mappings = [
              { input = "Control{H}"; output = "Backspace"; }
              { input = "Control{M}"; output = "Enter"; }
            ];
          }
        ]
      '';
      description = ''
        Enable mappings only in specific contexts or if only {option}`mappings`
        is specified then it is enabled unconditionally.

        Prepend "no" to the option's name (not applicable for {option}`mappings`)
        to indicate reverse option.
        For example, {option}`system` will activate the mappings in specified
        system but {option}`nosystem` will activate it in all systems except
        the one specified.

        If at least one of the context is specified but {option}`mappings` is
        left unspecified, then the context shares {option}`mappings` of the next context.
      '';
    };

    extraConfig = mkOption {
      type = types.lines;
      default = "";
      description = "Extra configuration lines to add.";
    };

    extraConfigFirst = mkEnableOption null // {
      description = "Whether to put lines in {option}`extraConfig` before {option}`contexts`";
    };

    systemd = {
      enable = mkEnableOption "systemd service for autostarting {command}`keymapper`";
      tray = mkEnableOption "tray icon" // { default = true; };
      wantedBy = mkOption {
        type = types.listOf types.str;
        default = [ "graphical-session.target" ];
        description = "Systemd units that want {command}`keymapper` to be started.";
      };
    };
  };

  config = mkIf cfg.enable {
    home.packages = [ cfg.package ];

    xdg.configFile."keymapper.conf".text =
      concatStringsSep "\n\n"
        (foldl (acc: x: acc ++ (optional (x != "") x)) [ ] (
          if !cfg.extraConfigFirst
          then [
            (generateAliases cfg.aliases)
            (generateConfig cfg.contexts)
            cfg.extraConfig
          ]
          else [
            (generateAliases cfg.aliases)
            cfg.extraConfig
            (generateConfig cfg.contexts)
          ]
        ));

    systemd.user.services.keymapper = mkIf cfg.systemd.enable {
      Unit.Description = "Keymapper";
      Service = {
        Type = "exec";
        ExecStart = "${cfg.package}/bin/keymapper -u -v -c ${config.xdg.configHome + "/keymapper.conf"}" + optionalString (!cfg.systemd.tray) " --no-tray";
        Restart = "always";
      };
      Install.WantedBy = cfg.systemd.wantedBy;
    };
  };

  meta.maintainers = with maintainers; [ spitulax ];
}
