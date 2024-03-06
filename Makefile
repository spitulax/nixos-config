.PHONY: nixos home upgrade update upinput repl clean delete check

nixos:
	nh os switch

home:
	nh home switch

upgrade: update nixos

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
