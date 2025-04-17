{ config
, pkgs
, outputs
, lib
, ...
}:
let
  cfg = config.configs.nix;
in
{
  options.configs.nix.useAccessToken = lib.mkEnableOption "" // {
    description = "Whether to use GitHub access token for increased bandwidth. Requires sops.";
  };

  config = lib.mkMerge [
    {
      home.packages = with pkgs; [
        nix-output-monitor
        nvd
      ];

      nix = {
        package = lib.mkForce pkgs.nix;
        settings = {
          inherit (outputs.vars) substituters trusted-public-keys;
        };
        extraOptions = lib.optionalString cfg.useAccessToken ''
          !include ${config.sops.secrets.nix-access-tokens.path}
        '';
      };

      programs.nh = {
        enable = true;
        package = pkgs.nh.override { inherit (pkgs) nix-output-monitor nvd; };
        flake = "${config.home.homeDirectory}/Config";
      };
    }

    (lib.mkIf cfg.useAccessToken {
      sops.secrets.nix-access-tokens = {
        sopsFile = /${outputs.vars.usersSecretsPath}/bintang/nix-access-tokens.yaml;
      };
    })
  ];
}
