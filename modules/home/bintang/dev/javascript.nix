{ pkgs
, ...
}: {
  home.packages = with pkgs; [
    nodePackages.nodejs
    typescript
    typescript-language-server
    deno
  ];
}
