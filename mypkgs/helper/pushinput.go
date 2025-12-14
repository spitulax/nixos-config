package main

import (
	"flag"
	"fmt"
	"io"
)

type SubcommandPushinput struct {
	flags      *flag.FlagSet
	cachixName *string
}

func NewSubcommandPushinput() (s SubcommandPushinput) {
	s.flags = NewFlagSet(s.Name())
	s.cachixName = FlagCachixName(s.flags)
	return s
}

func (s SubcommandPushinput) Name() string {
	return "pushinput"
}

func (s SubcommandPushinput) Usage() string {
	return "Push this flake's inputs to cachix"
}

func (s SubcommandPushinput) Run() error {
	if err := PushInputs(*s.cachixName); err != nil {
		return err
	}

	return nil
}

func (s SubcommandPushinput) PrintDefaults(output io.Writer) {
	s.flags.PrintDefaults()
}

func (s SubcommandPushinput) Parse(args []string) {
	s.flags.Parse(args)
}

func PushInputs(cachixName string) error {
	fmt.Println("\033[1;34mPushing inputs to cachix...\033[0m")

	// TODO: Implement pushinputs
	panic("Unimplemented")
}
