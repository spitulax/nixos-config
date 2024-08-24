{ pkgs
, myLib
, ...
}: {
  imports = myLib.importIn ./fish;

  programs.fish = {
    enable = true;

    interactiveShellInit =
      (builtins.readFile ./fish/init.fish) + (builtins.readFile ./fish/binds.fish);

    plugins = [
      {
        name = "fzf.fish";
        src = pkgs.fetchFromGitHub {
          owner = "PatrickF1";
          repo = "fzf.fish";
          rev = "v10.3";
          hash = "sha256-T8KYLA/r/gOKvAivKRoeqIwE2pINlxFQtZJHpOy9GMM=";
        };
      }
    ];
  };
}
