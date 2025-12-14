# RETIRED
{ config
, inputs
, pkgs
, lib
, ...
}:
let
  plugins = import ./plugins.nix { inherit pkgs; };
  pluginCollection =
    let
      # https://github.com/yazi-rs/plugins
      extraPlugins = pkgs.fetchFromGitHub {
        owner = "yazi-rs";
        repo = "plugins";
        rev = "ad52adf917d6dd679dbc2dcefa3a9384654bd1c7";
        hash = "sha256-UOSH8RM+6VkQqi14bwUdFUNm8CgbDRlNial9VevjYuU=";
      };
    in
    pkgs.stdenvNoCC.mkDerivation {
      name = "yazi-plugins";
      src = ./plugins;
      dontConfigure = true;
      dontBuild = true;
      installPhase = ''
        mkdir -p $out
        for x in $(find ${extraPlugins} -name '*.yazi' -type d); do
          outDir=$(echo -n $x | sed 's/^\/nix\/store\/.*\///')
          mkdir -p $outDir
          cp -r $x/* $outDir/
        done
        mv ./* $out/
      '';
    };
in
{
  options.configs.yazi.enable = lib.mkEnableOption "yazi file manager";

  config = lib.mkIf config.configs.yazi.enable {
    programs.yazi = {
      enable = true;
      package = pkgs.inputs.yazi.yazi.override {
        runtimeDeps = _: [ ];
      };
      enableFishIntegration = false;
      plugins =
        builtins.listToAttrs
          (map
            (x:
              lib.nameValuePair
                ((x:
                  if lib.hasSuffix ".yazi" x
                  then (lib.removeSuffix ".yazi" x)
                  else x) x.repo)
                x)
            plugins);
    };

    home.packages = with pkgs; [
      ffmpegthumbnailer
    ];

    # TODO: global theming
    xdg.configFile = {
      "yazi/yazi.toml".source = ./yazi.toml;
      "yazi/keymap.toml".source = ./keymap.toml;
      "yazi/init.lua".source = ./init.lua;
      "yazi/theme.toml".source = "${inputs.catppuccin-yazi}/themes/mocha.toml";
      "yazi/plugins" = {
        source = pluginCollection;
        recursive = true;
      };
      # https://github.com/catppuccin/yazi/blob/9bfdccc2b78d7493fa5c5983bc176a0bc5fef164/themes/mocha.toml#L32
      "yazi/Catppuccin-mocha.tmTheme".source = "${inputs.catppuccin-bat}/themes/Catppuccin Mocha.tmTheme";
    };
  };
}
