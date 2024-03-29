{ config
, pkgs
, ...
}: {
  programs.gh = {
    enable = true;
    extensions = [ pkgs.gh-markdown-preview ];
    gitCredentialHelper = {
      enable = true;
      hosts = [ "https://github.com" "https://gist.github.com" ];
    };
    settings = {
      prompt = "enabled";
      git_protocol = "ssh";
      editor = "nvim";
    };
  };

  sops.secrets.gh-hosts = {
    sopsFile = ../../../secrets/bintang/gh.yaml;
    path = "${config.xdg.configHome}/gh/hosts.yml";
  };
}
