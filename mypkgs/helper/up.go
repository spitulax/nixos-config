package main

import (
	"flag"
	"io"
)

type SubcommandUp struct {
	flags      *flag.FlagSet
	useNom     *bool
	cachixName *string
	UpscriptOpts
}

func NewSubcommandUp() (s SubcommandUp) {
	s.flags = NewFlagSet(s.Name())
	s.useNom = FlagNom(s.flags)
	s.cachixName = FlagCachixName(s.flags)
	s.UpscriptOpts = NewUpscriptOpts(s.flags)
	return s
}

func (s SubcommandUp) Name() string {
	return "up"
}

func (s SubcommandUp) Usage() string {
	return "Full update routine"
}

func (s SubcommandUp) Run() error {
	if err := Upinput(); err != nil {
		return err
	}

	if err := Upscript(s.UpscriptOpts); err != nil {
		return err
	}

	// if err := Build(*s.useNom); err != nil {
	// 	return err
	// }
	//
	// if err := PushPkgs(*s.cachixName); err != nil {
	// 	return err
	// }

	if err := Uplist(); err != nil {
		return err
	}

	return nil
}

func (s SubcommandUp) PrintDefaults(output io.Writer) {
	s.flags.SetOutput(output)
	s.flags.PrintDefaults()
}

func (s SubcommandUp) Parse(args []string) {
	s.flags.Parse(args)
}
