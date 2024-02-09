{ pkgs
, config
, inputs
, outputs
, ...
}: {
  users.users.bintang = {
    isNormalUser = true;
    description = "Bintang";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.fish;
    packages = with pkgs; [ home-manager ];
  };

  home-manager.users.bintang = import ../../users/bintang/${config.networking.hostName}.nix;
  home-manager.extraSpecialArgs = { inherit inputs outputs; };
}
