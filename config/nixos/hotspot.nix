{ config
, lib
, pkgs
, ...
}:
let
  cfg = config.configs.hotspot;

  script = pkgs.writeShellScriptBin "hotspot" ''
    quit () {
        nmcli r wifi on
    }

    if [[ $# -lt 2 ]]; then
        echo "$0 <ssid> <password> [gateway]" >&2
        exit 1
    fi

    trap quit EXIT

    SSID=$1
    PASSWORD=$2
    [[ -v 3 ]] && GATEWAY=$3

    nmcli r wifi off
    rfkill unblock wlan

    if [[ -v GATEWAY ]]; then
        sudo lnxrouter --ap wlp1s0 "$SSID" -p "$PASSWORD" -g "$GATEWAY" --qr
    else
        sudo lnxrouter --ap wlp1s0 "$SSID" -p "$PASSWORD" --qr
    fi
  '';
in
{
  options.configs.hotspot.enable = lib.mkEnableOption "hotspot (via linux-router)";

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      linux-router
      qrencode
      script
    ];
  };
}
