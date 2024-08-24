{ config
, pkgs
, inputs
, lib
, outputs
, ...
}:
let
  name = "Bintang";
  username = "bintang";
in
{
  imports = [
    inputs.home-manager.nixosModules.home-manager
  ];

  config = lib.mkIf (builtins.elem username config.configs.users) {
    users.users.${username} = {
      isNormalUser = true;
      description = name;
      extraGroups = [
        "input"
        "networkmanager"
        "wheel"
        "gamemode"
        "libvirtd"
      ];
      shell = pkgs.fish;
      packages = with pkgs; [ home-manager ];
      openssh.authorizedKeys.keyFiles = [
        ../../../modules/home/${username}/keys/ssh-rsa.pub # NOTE: the rsa key sould be password protected
        ../../../modules/home/${username}/keys/ssh-ed25519.pub
      ];
      hashedPasswordFile = config.sops.secrets."password-${username}".path;
    };

    sops.secrets = {
      "password-${username}" = {
        neededForUsers = true;
        sopsFile = "${outputs.vars.globalSecretsPath}/password.yaml";
      };
    };

    home-manager.users.${username} = import ../../../users/${username}_${config.networking.hostName};
  };
}
