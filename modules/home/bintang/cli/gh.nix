{ pkgs
, config
, outputs
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
    sopsFile = "${outputs.vars.usersSecretsPath}/bintang/gh-hosts.yaml";
    path = "${config.xdg.configHome}/gh/hosts.yml";
  };
}
