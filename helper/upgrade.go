package main

import (
	"flag"
	"fmt"
	"io"
	"os/exec"
	"strings"
)

type UpgradeOpts struct {
	buildOnly *bool
}

func NewUpgradeOpts(f *flag.FlagSet) (o UpgradeOpts) {
	o.buildOnly = f.Bool("build-only", false, "Only build, do not update")
	return o
}

type SubcommandUpgrade struct {
	flags *flag.FlagSet
	UpgradeOpts
	NvimUpdateOpts
	NixosOpts
}

func NewSubcommandUpgrade() (s SubcommandUpgrade) {
	s.flags = NewFlagSet(s.Name())
	s.UpgradeOpts = NewUpgradeOpts(s.flags)
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
	if (!*s.buildOnly) {
		if err := Update(*s.configName); err != nil {
			return err
		}
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
			if err := Run("home-manager news --flake $XDG_FLAKE_DIR"); err != nil {
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
