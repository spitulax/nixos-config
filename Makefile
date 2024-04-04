.PHONY: build nixos home upgrade update upinput repl clean delete check

upgrade: update build

build: nixos
	git add -A
	git commit -m "build $(shell date '+%F %R')"

nixos:
	nh os switch

home:
	nh home switch

update:
	nix flake update

upinput:
	nix flake lock --update-input $(i)

repl:
	nix repl -f flake:nixpkgs

clean:
	nh clean user

delete:
	nh clean all

check:
	statix check .
