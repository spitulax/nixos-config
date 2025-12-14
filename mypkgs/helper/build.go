package main

import (
	"flag"
	"fmt"
	"io"
)

type SubcommandBuild struct {
	flags  *flag.FlagSet
	useNom *bool
}

func NewSubcommandBuild() (s SubcommandBuild) {
	s.flags = NewFlagSet(s.Name())
	s.useNom = FlagNom(s.flags)
	return s
}

func (s SubcommandBuild) Name() string {
	return "build"
}

func (s SubcommandBuild) Usage() string {
	return "Build cached packages"
}

func (s SubcommandBuild) Run() error {
	if err := Build(*s.useNom); err != nil {
		return err
	}
	return nil
}

func (s SubcommandBuild) PrintDefaults(output io.Writer) {
	s.flags.SetOutput(output)
	s.flags.PrintDefaults()
}

func (s SubcommandBuild) Parse(args []string) {
	s.flags.Parse(args)
}

func Build(useNom bool) error {
	fmt.Println("\033[1;34mBuilding packages...\033[0m")

	var cmd string
	if useNom {
		cmd = "build .#cached --log-format internal-json -v |& nom --json"
	} else {
		cmd = "build .#cached"
	}

	if err := Nix(cmd); err != nil {
		return err
	}

	return nil
}
