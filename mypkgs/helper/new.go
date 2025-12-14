package main

import (
	"flag"
	"io"
)

type SubcommandNew struct {
	flags      *flag.FlagSet
	useNom     *bool
	cachixName *string
	UpscriptOpts
}

func NewSubcommandNew() (s SubcommandNew) {
	s.flags = NewFlagSet(s.Name())
	s.UpscriptOpts = NewUpscriptOpts(s.flags)
	return s
}

func (s SubcommandNew) Name() string {
	return "new"
}

func (s SubcommandNew) Usage() string {
	return "Set up newly added packages/flakes"
}

func (s SubcommandNew) Run() error {
	if err := Upscript(s.UpscriptOpts); err != nil {
		return err
	}

	return nil
}

func (s SubcommandNew) PrintDefaults(output io.Writer) {
	s.flags.SetOutput(output)
	s.flags.PrintDefaults()
}

func (s SubcommandNew) Parse(args []string) {
	s.flags.Parse(args)
	*s.skipExist = true
}
