package main

import (
	"flag"
	"fmt"
	"io"
)

type NixosOpts struct {
	debug *bool
}

func NewNixosOpts(f *flag.FlagSet) (o NixosOpts) {
	o.debug = f.Bool("debug", false, "Add --show-trace option")
	return o
}

type SubcommandNixos struct {
	flags *flag.FlagSet
	NixosOpts
}

func NewSubcommandNixos() (s SubcommandNixos) {
	s.flags = NewFlagSet(s.Name())
	s.NixosOpts = NewNixosOpts(s.flags)
	return s
}

func (s SubcommandNixos) Name() string {
	return "nixos"
}

func (s SubcommandNixos) Usage() string {
	return "Build and apply system config"
}

func (s SubcommandNixos) Run() error {
	if err := Nixos(*s.debug); err != nil {
		return err
	}
	return nil
}

func (s SubcommandNixos) PrintDefaults(output io.Writer) {
	s.flags.SetOutput(output)
	s.flags.PrintDefaults()
}

func (s SubcommandNixos) Parse(args []string) {
	s.flags.Parse(args)
}

func Nixos(debug bool) error {
	fmt.Println("\033[1;34mBuilding system config...\033[0m")

	debugOpts := ""
	if debug {
		debugOpts = " -- --show-trace"
	}

	if err := Run(fmt.Sprintf("nh os switch%s", debugOpts)); err != nil {
		return err
	}

	return nil
}
