{ pkgs
, ...
}: {
  home.packages = with pkgs; [
    nodePackages.nodejs
    typescript
    deno
    nodePackages.typescript-language-server
  ];
}
