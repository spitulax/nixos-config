package main

import (
	"flag"
	"io"
)

type SubcommandUpdate struct {
	flags *flag.FlagSet
	NvimUpdateOpts
}

func NewSubcommandUpdate() (s SubcommandUpdate) {
	s.flags = NewFlagSet(s.Name())
	s.NvimUpdateOpts = NewNvimUpdateOpts(s.flags)
	return s
}

func (s SubcommandUpdate) Name() string {
	return "update"
}

func (s SubcommandUpdate) Usage() string {
	return "Update flake, mypkgs and neovim plugins"
}

func (s SubcommandUpdate) Run() error {
	if err := Update(*s.configName); err != nil {
		return err
	}

	return nil
}

func (s SubcommandUpdate) PrintDefaults(output io.Writer) {
	s.flags.SetOutput(output)
	s.flags.PrintDefaults()
}

func (s SubcommandUpdate) Parse(args []string) {
	s.flags.Parse(args)
}

func Update(configName string) error {
	if err := FlakeUpdate(); err != nil {
		return err
	}

	if err := Mypkgs("up"); err != nil {
		return err
	}

	if err := NvimUpdate(configName); err != nil {
		return err
	}

	return nil
}
