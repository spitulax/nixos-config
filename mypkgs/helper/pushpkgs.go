package main

import (
	"errors"
	"flag"
	"fmt"
	"io"
	"strings"
)

type SubcommandPushpkgs struct {
	flags      *flag.FlagSet
	cachixName *string
}

func NewSubcommandPushpkgs() (s SubcommandPushpkgs) {
	s.flags = NewFlagSet(s.Name())
	s.cachixName = FlagCachixName(s.flags)
	return s
}

func (s SubcommandPushpkgs) Name() string {
	return "pushpkgs"
}

func (s SubcommandPushpkgs) Usage() string {
	return "Push recently built packages to cachix (Typically used right after calling `build`)"
}

func (s SubcommandPushpkgs) Run() error {
	if err := PushPkgs(*s.cachixName); err != nil {
		return err
	}

	return nil
}

func (s SubcommandPushpkgs) PrintDefaults(output io.Writer) {
	s.flags.PrintDefaults()
}

func (s SubcommandPushpkgs) Parse(args []string) {
	s.flags.Parse(args)
}

func PushPkgs(cachixName string) error {
	fmt.Println("\033[1;34mPushing packages...\033[0m")

	paths, pathsErr := Paths()
	if pathsErr != nil {
		return pathsErr
	}
	pathsJoined := strings.Join(paths, " ")

	if err := Cachix("push '" + cachixName + "' " + pathsJoined); err != nil {
		return errors.Join(err, fmt.Errorf("Push(): Failed to run cachix"))
	}

	return nil
}
