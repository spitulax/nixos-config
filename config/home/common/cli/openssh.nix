{ config
, lib
, ...
}: {
  options.configs.cli.openssh.enable = lib.mkEnableOption "SSH" // {
    default = true;
  };

  config = lib.mkIf config.configs.cli.openssh.enable {
    programs.ssh = {
      enable = true;
      enableDefaultConfig = false;
    };
  };
}
