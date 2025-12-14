{ lib
, stdenv
, gitHubPkg
}:
let
  # https://github.com/NixOS/nixpkgs/blob/nixos-unstable/pkgs/development/libraries/hunspell/dictionaries.nix
  mkDict =
    { pname, readmeFile, dictFileName, ... }@args:
    stdenv.mkDerivation ({
      inherit pname;
      installPhase = ''
        runHook preInstall
        # hunspell dicts
        install -dm755 "$out/share/hunspell"
        install -m644 ${dictFileName}.dic "$out/share/hunspell/"
        install -m644 ${dictFileName}.aff "$out/share/hunspell/"
        # myspell dicts symlinks
        install -dm755 "$out/share/myspell/dicts"
        ln -sv "$out/share/hunspell/${dictFileName}.dic" "$out/share/myspell/dicts/"
        ln -sv "$out/share/hunspell/${dictFileName}.aff" "$out/share/myspell/dicts/"
        # docs
        install -dm755 "$out/share/doc"
        install -m644 ${readmeFile} $out/share/doc/${pname}.txt
        runHook postInstall
      '';
    } // args);

in
# TODO: upstream this
  # https://github.com/wooorm/dictionaries
  # https://github.com/NixOS/nixpkgs/blob/nixos-unstable/pkgs/development/libraries/hunspell/dictionaries.nix
mkDict (
  (gitHubPkg {
    owner = "shuLhan";
    repo = "hunspell-id";
    ref = "dev";
  }) // {
    pname = "hunspell-dict-id-id";
    dictFileName = "id_ID";
    readmeFile = "README";
    dontBuild = true;
    meta = with lib; {
      description = "Hunspell dictionary for Indonesian (Indonesia)";
      homepage = "https://github.com/shuLhan/hunspell-id";
      license = with licenses; [ lgpl3Only ];
      maintainers = with maintainers; [ spitulax ];
      platforms = platforms.all;
    };
  }
)
