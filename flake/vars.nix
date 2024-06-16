# Variables that are shared with configs, modules, etc. so they are declared in flake
{
  # Binary cache substituters
  substituters = [
    "https://cache.nixos.org"
    "https://nix-gaming.cachix.org"
    "https://hyprland.cachix.org"
    "https://nix-on-droid.cachix.org"
    "https://nix-community.cachix.org"
    "https://spitulax.cachix.org"
  ];
  trusted-public-keys = [
    "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
    "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="
    "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
    "nix-on-droid.cachix.org-1:56snoMJTXmDRC1Ei24CmKoUqvHJ9XCp+nidK7qkMQrU="
    "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    "spitulax.cachix.org-1:GQRdtUgc9vwHTkfukneFHFXLPOo0G/2lj2nRw66ENmU="
  ];

  globalSecretsPath = ../secrets/global;
  hostsSecretsPath = ../secrets/hosts;
  usersSecretsPath = ../secrets/users;
}
