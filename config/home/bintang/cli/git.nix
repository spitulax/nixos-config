{ config
, lib
, pkgs
, ...
}:
let
  cfg = config.configs.cli.git;
in
{
  options.configs.cli.git = {
    enable = lib.mkEnableOption "git" // {
      default = true;
    };
    gh = lib.mkEnableOption "GitHub CLI";
  };

  config = lib.mkMerge [
    (lib.mkIf cfg.enable {
      programs.git = {
        enable = true;
        extraConfig = {
          core = {
            eol = "lf";
            editor = "nvim";
          };
          diff = {
            tool = "difftool-nvim";
            prompt = false;
          };
          "difftool \"difftool-nvim\"" = {
            cmd = "nvim -d \"$LOCAL\" \"$REMOTE\"";
          };
          init = {
            defaultBranch = "main";
          };
          user = {
            name = "Bintang Adiputra Pratama";
            email = "bintangadiputra@proton.me";
            signingkey = "929ED6C40414D3F5";
          };
          commit.gpgSign = true;
          gpg.program = "${config.programs.gpg.package}/bin/gpg2";
        };
      };
    })

    (lib.mkIf cfg.gh {
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
    })
  ];
}
