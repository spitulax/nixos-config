{ lib }:
lib.genAttrsEachDirs ./. (n: { path = ./${n}; description = n; })
