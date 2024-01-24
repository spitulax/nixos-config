{ lib, config, pkgs, inputs, ... }: {
  home = {
    username = "bintang";
    homeDirectory = "/home/${config.home.username}";
    stateVersion = "23.11";
  };
}
