package main

import (
	"flag"
	"fmt"
	"io"
)

type SubcommandNixos struct {
	flags *flag.FlagSet
}

func NewSubcommandNixos() (s SubcommandNixos) {
	s.flags = NewFlagSet(s.Name())
	return s
}

func (s SubcommandNixos) Name() string {
	return "nixos"
}

func (s SubcommandNixos) Usage() string {
	return "Build and apply system config"
}

func (s SubcommandNixos) Run() error {
	if err := Nixos(); err != nil {
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

func Nixos() error {
	fmt.Println("\033[1;34mBuilding system config...\033[0m")

	if err := Run("nh os switch"); err != nil {
		return err
	}

	return nil
}
