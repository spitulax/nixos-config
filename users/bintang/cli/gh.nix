{
  config
, pkgs
, ...
}: {
  programs.gh = {
    enable = true;
    gitCredentialHelper = {
      enable = true;
      hosts = [ "https://github.com" "https://gist.github.com" ];
    };
    settings = {
      editor = "nvim";
    };
  };
}
