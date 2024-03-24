{
  # TODO: the swap partition may be unnecessary
  zramSwap = {
    enable = true;
    algorithm = "zstd";
    priority = 5;
    memoryPercent = 50;
  };
}
