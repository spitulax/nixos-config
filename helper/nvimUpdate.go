package main

import (
	"flag"
	"fmt"
	"io"
	"os/exec"
)

type NvimUpdateOpts struct {
	configName *string
}

func NewNvimUpdateOpts(f *flag.FlagSet) (o NvimUpdateOpts) {
	o.configName = f.String("config", "common", "The folder in config/home that houses the neovim config")
	return o
}

type SubcommandNvimUpdate struct {
	flags *flag.FlagSet
	NvimUpdateOpts
}

func NewSubcommandNvimUpdate() (s SubcommandNvimUpdate) {
	s.flags = NewFlagSet(s.Name())
	s.NvimUpdateOpts = NewNvimUpdateOpts(s.flags)
	return s
}

func (s SubcommandNvimUpdate) Name() string {
	return "nvimup"
}

func (s SubcommandNvimUpdate) Usage() string {
	return "Update neovim plugins"
}

func (s SubcommandNvimUpdate) Run() error {
	if err := NvimUpdate(*s.configName); err != nil {
		return err
	}
	return nil
}

func (s SubcommandNvimUpdate) PrintDefaults(output io.Writer) {
	s.flags.SetOutput(output)
	s.flags.PrintDefaults()
}

func (s SubcommandNvimUpdate) Parse(args []string) {
	s.flags.Parse(args)
}

func NvimUpdate(configName string) error {
	if _, err := exec.LookPath("lazyup"); err != nil {
		return fmt.Errorf("Failed to find lazyup script")
	}

	if err := Run(fmt.Sprintf("lazyup %s", configName)); err != nil {
		return err
	}

	return nil
}
