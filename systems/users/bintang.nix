{
  pkgs,
  config,
  ...
}: {
  users.users.bintang = {
    isNormalUser = true;
    description = "Bintang";
    extraGroups = ["networkmanager" "wheel"];
    shell = pkgs.fish;
    packages = with pkgs; [home-manager];
  };
}
