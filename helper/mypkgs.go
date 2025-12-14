package main

import (
	"flag"
	"fmt"
	"io"
	"os"
)

type MypkgsOpts struct {
	args *string
}

func NewMypkgsOpts(f *flag.FlagSet) (o MypkgsOpts) {
	o.args = f.String("args", "", "Arguments to be passed to mypkgs helper")
	return o
}

type SubcommandMypkgs struct {
	flags *flag.FlagSet
	MypkgsOpts
}

func NewSubcommandMypkgs() (s SubcommandMypkgs) {
	s.flags = NewFlagSet(s.Name())
	s.MypkgsOpts = NewMypkgsOpts(s.flags)
	return s
}

func (s SubcommandMypkgs) Name() string {
	return "mypkgs"
}

func (s SubcommandMypkgs) Usage() string {
	return "Run mypkgs helper"
}

func (s SubcommandMypkgs) Run() error {
	if err := Mypkgs(*s.args); err != nil {
		return err
	}
	return nil
}

func (s SubcommandMypkgs) PrintDefaults(output io.Writer) {
	s.flags.SetOutput(output)
	s.flags.PrintDefaults()
}

func (s SubcommandMypkgs) Parse(args []string) {
	s.flags.Parse(args)
}

func Mypkgs(args string) error {
	if len(args) == 0 {
		return fmt.Errorf("Mypkgs(): Empty argument")
	}

	fmt.Printf("\033[1;34mRunning mypkgs helper with argument `%s`...\033[0m\n", args)

	prevWd, prevWdErr := os.Getwd()
	if prevWdErr != nil {
		return prevWdErr
	}

	if err := os.Chdir("mypkgs"); err != nil {
		return err
	}

	if err := Nix(fmt.Sprintf("run .#helper -- %s", args)); err != nil {
		return err
	}

	if err := os.Chdir(prevWd); err != nil {
		return err
	}

	return nil
}
