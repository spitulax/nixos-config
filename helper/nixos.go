package main

import (
	"flag"
	"fmt"
	"io"
)

type NixosOpts struct {
	debug *bool
	abortOnWarn *bool
}

func NewNixosOpts(f *flag.FlagSet) (o NixosOpts) {
	o.debug = f.Bool("debug", false, "Add --show-trace option")
	o.abortOnWarn = f.Bool("abort-on-warn", false, "Abort when encountering warning, useful for tracking the source of the warning")
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
	if err := NixosEx(*s.debug, *s.abortOnWarn); err != nil {
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
	return NixosEx(debug, false)
}

func NixosEx(debug bool, abortOnWarn bool) error {
	fmt.Println("\033[1;34mBuilding system config...\033[0m")

	debugOpts := ""
	if debug {
		debugOpts = " -- --show-trace"
	}
	if abortOnWarn {
		debugOpts = " -- --option abort-on-warn true --show-trace"
	}

	if err := Run(fmt.Sprintf("nh os switch%s", debugOpts)); err != nil {
		return err
	}

	return nil
}
