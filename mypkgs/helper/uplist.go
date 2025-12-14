package main

import (
	"errors"
	"fmt"
	"io"
)

type SubcommandUplist struct{}

func NewSubcommandUplist() (s SubcommandUplist) {
	return s
}

func (s SubcommandUplist) Name() string {
	return "uplist"
}

func (s SubcommandUplist) Usage() string {
	return "Update `list.md`"
}

func (s SubcommandUplist) Run() error {
	if err := Uplist(); err != nil {
		return err
	}

	return nil
}

func (s SubcommandUplist) PrintDefaults(output io.Writer) {
	return
}

func (s SubcommandUplist) Parse(args []string) {
	return
}

func Uplist() error {
	fmt.Println("\033[1;34mUpdating package list...\033[0m")

	path, pathErr := NixBuild(".#mypkgs-list")
	if pathErr != nil {
		return pathErr
	}

	if err := CopyToDir(".", path, "list.md"); err != nil {
		return errors.Join(err, fmt.Errorf("Uplist(): Failed to copy list"))
	}

	return nil
}
