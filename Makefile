.PHONY: nixos home update upinput repl clean delete

nixos:
	nh os switch -- --accept-flake-config

home:
	nh home switch -- --accept-flake-config

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
