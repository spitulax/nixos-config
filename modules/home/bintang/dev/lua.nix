{ pkgs
, ...
}: {
  home.packages = with pkgs; [
    luajitPackages.lua
    stylua
    lua-language-server
  ];
}
