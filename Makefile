.PHONY: build nixos home update upgrade clean delete check exam

build: nixos
	git add -A
	git commit -m "build $(shell date '+%F %R')"

nixos:
	nh os switch

home:
	nh home switch

update:
	nix flake update $(i)

upgrade:
	lazyup
	nix flake update
	nh os switch

clean:
	nh clean user

delete:
	nh clean all

check:
	statix check .
	nix flake check

exam:
	nh os switch -- --show-trace -L -v
