{ pkgs
, config
, inputs
, outputs
, ...
}: {
  imports = [
    inputs.home-manager.nixosModules.home-manager
  ];

  users.users.bintang = {
    isNormalUser = true;
    description = "Bintang";
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
      ../../home/bintang/keys/ssh-rsa.pub # NOTE: add password to the rsa key
      ../../home/bintang/keys/ssh-ed25519.pub
    ];
    hashedPasswordFile = config.sops.secrets.password-bintang.path;
  };

  sops.secrets = {
    password-bintang = {
      neededForUsers = true;
      sopsFile = "${outputs.vars.globalSecretsPath}/password.yaml";
    };
  };

  home-manager.users.bintang = import ../../../users/bintang_${config.networking.hostName};
}
