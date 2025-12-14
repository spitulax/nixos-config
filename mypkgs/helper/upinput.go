package main

import (
	"errors"
	"fmt"
	"io"
)

type SubcommandUpinput struct{}

func NewSubcommandUpinput() (s SubcommandUpinput) {
	return s
}

func (s SubcommandUpinput) Name() string {
	return "upinput"
}

func (s SubcommandUpinput) Usage() string {
	return "Update flake inputs"
}

func (s SubcommandUpinput) Run() error {
	if err := Upinput(); err != nil {
		return err
	}

	return nil
}

func (s SubcommandUpinput) PrintDefaults(output io.Writer) {
	return
}

func (s SubcommandUpinput) Parse(args []string) {
	return
}

func Upinput() error {
	fmt.Println("\033[1;34mUpdating flake inputs...\033[0m")

	if err := Nix("flake update"); err != nil {
		return errors.Join(err, fmt.Errorf("Upinput(): Failed to update flake input"))
	}

	return nil
}
