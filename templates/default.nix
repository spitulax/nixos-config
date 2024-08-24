{ myLib }:
myLib.genAttrsEachDir ./. (n: { path = ./${n}; description = n; })
