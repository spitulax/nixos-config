package main

import (
	"flag"
	"fmt"
	"io"
)

type SubcommandFlakeUpdate struct {
	flags *flag.FlagSet
}

func NewSubcommandFlakeUpdate() (s SubcommandFlakeUpdate) {
	s.flags = NewFlagSet(s.Name())
	return s
}

func (s SubcommandFlakeUpdate) Name() string {
	return "flakeup"
}

func (s SubcommandFlakeUpdate) Usage() string {
	return "Update flake inputs"
}

func (s SubcommandFlakeUpdate) Run() error {
	if err := FlakeUpdate(); err != nil {
		return err
	}
	return nil
}

func (s SubcommandFlakeUpdate) PrintDefaults(output io.Writer) {
	s.flags.SetOutput(output)
	s.flags.PrintDefaults()
}

func (s SubcommandFlakeUpdate) Parse(args []string) {
	s.flags.Parse(args)
}

func FlakeUpdate() error {
	fmt.Println("\033[1;34mUpdating flake inputs...\033[0m")

	if err := Nix("flake update"); err != nil {
		return err
	}

	return nil
}
