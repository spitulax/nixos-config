{ inputs
, pkgs
, lib
, ...
}:
let
  plugins = import ./yazi/plugins.nix { inherit pkgs; };
  pluginCollection =
    let
      extraPlugins = pkgs.fetchFromGitHub {
        owner = "yazi-rs";
        repo = "plugins";
        rev = "9b1f2da88c08df9e9b679e14006c9718a8c55a2d";
        hash = "sha256-giOAJvlT3c37EbIz4pZt54mxZFKIgSSbMs2hD/mzvVc=";
      };
    in
    pkgs.stdenvNoCC.mkDerivation {
      name = "yazi-plugins";
      src = ./yazi/plugins;
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
  programs.yazi = {
    enable = true;
    package = inputs.yazi.packages.${pkgs.system}.yazi.override {
      withFile = false;
      withJq = false;
      withPoppler = false;
      withUnar = false;
      withFfmpegthumbnailer = false;
      withFd = false;
      withRipgrep = false;
      withFzf = false;
      withZoxide = false;
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

  xdg.configFile = {
    "yazi/yazi.toml".source = ./yazi/yazi.toml;
    "yazi/keymap.toml".source = ./yazi/keymap.toml;
    "yazi/init.lua".source = ./yazi/init.lua;
    "yazi/theme.toml".source = "${inputs.catppuccin-yazi}/themes/mocha.toml";
    "yazi/plugins" = {
      source = pluginCollection;
      recursive = true;
    };
    # https://github.com/catppuccin/yazi/blob/9bfdccc2b78d7493fa5c5983bc176a0bc5fef164/themes/mocha.toml#L32
    "yazi/Catppuccin-mocha.tmTheme".source = "${inputs.catppuccin-bat}/themes/Catppuccin Mocha.tmTheme";
  };
}
