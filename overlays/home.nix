{ inputs
, pkgs
, ...
}: {
  brave = _: prev: {
    brave = prev.brave.override {
      libvaSupport = true;
      enableVideoAcceleration = true;
    };
  };
}
