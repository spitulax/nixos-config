{ pkgs
, config
, inputs
, outputs
, ...
}: {
  users.users.bintang = {
    isNormalUser = true;
    description = "Bintang";
    extraGroups = [ "input" "networkmanager" "wheel" ];
    shell = pkgs.fish;
    packages = with pkgs; [ home-manager ];
    openssh.authorizedKeys.keyFiles = [ ../../users/bintang/keys/ssh.pub ];
    hashedPasswordFile = config.sops.secrets.password-bintang.path;
  };

  sops.secrets.password-bintang = {
    sopsFile = ../global/secrets.yaml;
    neededForUsers = true;
  };

  home-manager.users.bintang = import ../../users/bintang/${config.networking.hostName}.nix;
}
