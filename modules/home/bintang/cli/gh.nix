{ pkgs
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

  xdg.configFile."gh/hosts.yml".text = ''
    github.com:
        git_protocol: ssh
        users:
            spitulax:
        user: spitulax
  '';
}
