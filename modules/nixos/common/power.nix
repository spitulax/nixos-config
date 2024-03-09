{ pkgs
, ...
}: {
  services = {
    power-profiles-daemon = {
      enable = true;
    };
    upower = {
      enable = true;
      percentageLow = 20;
      percentageCritical = 10;
      percentageAction = 5;
    };
  };
}
