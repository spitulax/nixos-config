package main

import (
	"flag"
	"os/exec"
)

func NewFlagSet(name string) *flag.FlagSet {
	return flag.NewFlagSet(name, flag.ExitOnError)
}

func FlagNom(f *flag.FlagSet) *bool {
	_, err := exec.LookPath("nom")
	hasNom := err == nil
	return f.Bool("nom", hasNom, "Whether to use nom")
}

func FlagCachixName(f *flag.FlagSet) *string {
	return f.String("cachix", DefaultCachixName, "Cachix cache to push the packages to")
}
