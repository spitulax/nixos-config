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
        (nh.override { inherit (pkgs) nix-output-monitor nvd; })
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

    }

    (lib.mkIf cfg.useAccessToken {
      sops.secrets.nix-access-tokens = {
        sopsFile = config.configs.requiredFiles.nixAccessToken;
      };

      configs.requiredFiles.nixAccessToken = /${outputs.vars.usersSecretsPath}/bintang/nix-access-tokens.yaml;
    })
  ];
}
