{ myLib }: {
  bintang = myLib.mkUser {
    name = "Bintang";
    username = "bintang";
    extraGroups = [
      "input"
      "networkmanager"
      "wheel"
      "gamemode"
      "libvirtd"
      "wireshark"
      "docker"
    ];
  };
}
