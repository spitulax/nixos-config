package main

import (
	"flag"
	"fmt"
	"io"
)

type SubcommandHome struct {
	flags *flag.FlagSet
}

func NewSubcommandHome() (s SubcommandHome) {
	s.flags = NewFlagSet(s.Name())
	return s
}

func (s SubcommandHome) Name() string {
	return "home"
}

func (s SubcommandHome) Usage() string {
	return "Build and apply home-manager config"
}

func (s SubcommandHome) Run() error {
	if err := Home(); err != nil {
		return err
	}
	return nil
}

func (s SubcommandHome) PrintDefaults(output io.Writer) {
	s.flags.SetOutput(output)
	s.flags.PrintDefaults()
}

func (s SubcommandHome) Parse(args []string) {
	s.flags.Parse(args)
}

func Home() error {
	fmt.Println("\033[1;34mBuilding home-manager config...\033[0m")

	if err := Run("nh home switch"); err != nil {
		return err
	}

	return nil
}
