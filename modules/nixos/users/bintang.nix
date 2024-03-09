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
    openssh.authorizedKeys.keyFiles = [ ../../../users/bintang/keys/ssh-rsa.pub ../../../users/bintang/keys/ssh-ed25519.pub ];
    hashedPasswordFile = config.sops.secrets.password-bintang.path;
  };

  sops.secrets = {
    password-bintang = {
      neededForUsers = true;
      sopsFile = ../../../secrets/global/secrets.yaml;
    };
    gh-hosts = {
      owner = "bintang";
      group = "users";
      sopsFile = ../../../secrets/bintang/gh.yaml;
    };
  };

  home-manager.users.bintang = import ../../../users/bintang/${config.networking.hostName}.nix;
}
