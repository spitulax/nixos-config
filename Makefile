.PHONY: build nixos home update upgrade upinput clean delete check

build: nixos
	git add -A
	git commit -m "build $(shell date '+%F %R')"

nixos:
	nh os switch

home:
	nh home switch

update:
	nix flake update

upgrade:
	lazyup
	nix flake update
	nh os switch

upinput:
	nix flake lock --update-input $(i)

clean:
	nh clean user

delete:
	nh clean all

check:
	statix check .
