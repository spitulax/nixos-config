{ inputs
, pkgs
, ...
}: {
  # Custom packages
  custom = final: _: import ../packages { pkgs = final; };

  brave = _: prev: {
    brave = prev.brave.override {
      libvaSupport = true;
      enableVideoAcceleration = true;
    };
  };
}
