package main

import (
	"flag"
	"fmt"
	"io"
	"os/exec"
	"strings"
)

type SubcommandUpgrade struct {
	flags *flag.FlagSet
	NvimUpdateOpts
	NixosOpts
}

func NewSubcommandUpgrade() (s SubcommandUpgrade) {
	s.flags = NewFlagSet(s.Name())
	s.NvimUpdateOpts = NewNvimUpdateOpts(s.flags)
	s.NixosOpts = NewNixosOpts(s.flags)
	return s
}

func (s SubcommandUpgrade) Name() string {
	return "upgrade"
}

func (s SubcommandUpgrade) Usage() string {
	return "Run a full system upgrade"
}

func (s SubcommandUpgrade) Run() error {
	if err := Update(*s.configName); err != nil {
		return err
	}

	if err := Nixos(*s.debug); err != nil {
		return err
	}

	if _, err := exec.LookPath("home-manager"); err == nil {
		fmt.Print("\033[1mDo you want to view home-manager news? [y/N] \033[0m")
		var ans string
		fmt.Scanln(&ans)
		ans = strings.ToLower(ans)
		if ans == "y" || ans == "yes" {
			if err := Run("home-manager news --flake $FLAKE_DIR"); err != nil {
				return err
			}
		}
	}

	return nil
}

func (s SubcommandUpgrade) PrintDefaults(output io.Writer) {
	s.flags.SetOutput(output)
	s.flags.PrintDefaults()
}

func (s SubcommandUpgrade) Parse(args []string) {
	s.flags.Parse(args)
}
