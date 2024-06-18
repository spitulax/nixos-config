{ pkgs
, outputs
, lib
, config
, ...
}: {
  nix = {
    package = lib.mkForce pkgs.nix;
    settings = {
      inherit (outputs.vars) substituters trusted-public-keys;
    };
    extraOptions = ''
      !include ${config.sops.secrets.nix-access-tokens.path}
    '';
  };

  sops.secrets.nix-access-tokens = {
    sopsFile = "${outputs.vars.usersSecretsPath}/bintang/nix-access-tokens.yaml";
  };
}
