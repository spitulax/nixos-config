{ lib
, myLib
, ...
}:
{
  imports = myLib.importIn ./.;

  options.configs.users = lib.mkOption {
    type = lib.types.listOf (lib.types.enum [
      "bintang"
    ]);
    default = [ ];
    description = "List of users to add.";
  };
}
