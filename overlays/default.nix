{ inputs, ... }: {
  nixpkgs = final: _prev: {
    pkgs = import inputs.nixpkgs {
      system = final.system;
      config.allowUnfree = true;
    };
  };
}
