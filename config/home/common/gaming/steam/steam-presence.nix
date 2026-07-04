{ config
, lib
, pkgs
, ...
}:
let
  cfg = config.configs.gaming.steam;

  package = pkgs.inputs.steam-presence.steam-presence;

  # Taken from https://github.com/JustTemmie/steam-presence/blob/main/nix/nixos-modules/steam-presence.nix
  discordApplicationId = "869994714093465680";
  localDiscordApplicationId = "1062648118375616594";

  configBaseFile = pkgs.writeText "steam-presence-config.base.json" (builtins.toJSON {
    STEAM_API_KEY = null;
    USER_IDS = [ "76561199246571011" ];
    DISCORD_APPLICATION_ID = discordApplicationId;
    FETCH_STEAM_RICH_PRESENCE = true;
    FETCH_STEAM_REVIEWS = false;
    ADD_STEAM_STORE_BUTTON = false;
    WEB_SCRAPE = false;
    COVER_ART = {
      STEAM_GRID_DB = {
        ENABLED = false;
        STEAM_GRID_API_KEY = null;
      };
      USE_STEAM_STORE_FALLBACK = true;
    };
    LOCAL_GAMES = {
      ENABLED = false;
      LOCAL_DISCORD_APPLICATION_ID = localDiscordApplicationId;
      GAMES = [ ];
    };
    GAME_OVERWRITE = {
      ENABLED = false;
      NAME = "Breath of the wild, now on steam!";
      SECONDS_SINCE_START = 0;
    };
    CUSTOM_ICON = {
      ENABLED = false;
      URL = "https://raw.githubusercontent.com/JustTemmie/steam-presence/main/readmeimages/defaulticon.png";
      TEXT = "Steam Presence on Discord";
    };
    BLACKLIST = [ ];
    WHITELIST = [ ];
  });

  service = {
    Unit = {
      Description = "Discord rich presence for Steam";
      After = [ "network-online.target" ];
    };
    Install.WantedBy = [ "default.target" ];

    Service =
      let
        preStartScript = pkgs.writeShellScriptBin "steam-presence-pre-start" ''
          set -euo pipefail
          RUNTIME_DIR="''${STEAM_PRESENCE_RUNTIME_DIR:-$HOME/.local/state/steam-presence}"
          ${pkgs.coreutils}/bin/mkdir -p "$RUNTIME_DIR"
          if [ ! -e "$RUNTIME_DIR/main.py" ]; then
            ${pkgs.coreutils}/bin/cp -r ${package}/share/steam-presence/. "$RUNTIME_DIR/"
          fi
          ${pkgs.coreutils}/bin/cp -Lf ${toString configBaseFile} "$RUNTIME_DIR/config.base.json"

          cd "$RUNTIME_DIR"
          in_base="config.base.json"
          out_tmp="config.json.tmp"
          out_final="config.json"
          ${pkgs.python3}/bin/python - "$in_base" "$out_tmp" <<'PY'
          import json, os, sys
          base_path, out_path = sys.argv[1], sys.argv[2]
          with open(base_path, "r") as f:
              data = json.load(f)

          def ensure_path(d, keys):
              cur = d
              for k in keys:
                  if k not in cur or not isinstance(cur[k], dict):
                      cur[k] = {}
                  cur = cur[k]
              return cur

          steam_key_file = os.environ.get("STEAM_API_KEY_FILE")
          if steam_key_file and os.path.isfile(steam_key_file):
              try:
                  with open(steam_key_file, "r") as f:
                      data["STEAM_API_KEY"] = f.read().strip()
              except Exception:
                  pass

          sgdb_key_file = os.environ.get("STEAM_GRID_API_KEY_FILE")
          if sgdb_key_file and os.path.isfile(sgdb_key_file):
              try:
                  ensure_path(data, ["COVER_ART", "STEAM_GRID_DB"])
                  with open(sgdb_key_file, "r") as f:
                      data["COVER_ART"]["STEAM_GRID_DB"]["STEAM_GRID_API_KEY"] = f.read().strip()
              except Exception:
                  pass

          with open(out_path, "w") as f:
              json.dump(data, f, indent=2)
          PY
          ${pkgs.coreutils}/bin/mv -f "$out_tmp" "$out_final"
        '';
      in
      {
        Environment = [
          "STEAM_PRESENCE_RUNTIME_DIR=%h/.local/state/steam-presence"
          "STEAM_API_KEY_FILE=${toString config.sops.secrets.steam-key-spitulax.path}"
        ];

        ExecStart = "${package}/bin/steam-presence";
        ExecStartPre = "${preStartScript}/bin/steam-presence-pre-start";
        WorkingDirectory = "%h/.local/state/steam-presence";
        Restart = "on-failure";
        RestartSec = "10s";
      };
  };
in
{
  options.configs.gaming.steam = {
    discordRPC = lib.mkEnableOption "Discord Rich Presence";
  };

  config = lib.mkIf cfg.discordRPC {
    assertions = [{
      assertion = config.configs.sops.enable;
      message = "`configs.sops.enable` must be true to use Discord RPC";
    }];

    systemd.user = {
      tmpfiles.rules = [
        "d %h/.local/state/steam-presence 755 - - -"
      ];
      services.steam-presence = service;
    };

    sops.secrets.steam-key-spitulax = {
      sopsFile = /${pkgs.myArgs.vars.usersSecretsPath}/${config.home.username}/steam-keys.yaml;
    };
  };
}
