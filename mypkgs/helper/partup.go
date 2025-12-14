package main

import (
	"flag"
	"io"
)

type SubcommandPartup struct {
	flags      *flag.FlagSet
	useNom     *bool
	cachixName *string
}

func NewSubcommandPartup() (s SubcommandPartup) {
	s.flags = NewFlagSet(s.Name())
	s.useNom = FlagNom(s.flags)
	s.cachixName = FlagCachixName(s.flags)
	return s
}

func (s SubcommandPartup) Name() string {
	return "partup"
}

func (s SubcommandPartup) Usage() string {
	return "Partial update (useful for modifying packages without updating other packages)"
}

func (s SubcommandPartup) Run() error {
	if err := Build(*s.useNom); err != nil {
		return err
	}

	if err := PushPkgs(*s.cachixName); err != nil {
		return err
	}

	if err := Uplist(); err != nil {
		return err
	}

	return nil
}

func (s SubcommandPartup) PrintDefaults(output io.Writer) {
	s.flags.SetOutput(output)
	s.flags.PrintDefaults()
}

func (s SubcommandPartup) Parse(args []string) {
	s.flags.Parse(args)
}
