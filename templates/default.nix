{ myLib }:
myLib.genAttrsEachDirs ./. (n: { path = ./${n}; description = n; })
