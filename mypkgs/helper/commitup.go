package main

import (
	"io"
)

type SubcommandCommitup struct{}

func NewSubcommandCommitup() (s SubcommandCommitup) {
	return s
}

func (s SubcommandCommitup) Name() string {
	return "commitup"
}

func (s SubcommandCommitup) Usage() string {
	return "Commit current changes as an update"
}

func (s SubcommandCommitup) Run() error {
	// TODO: Implement `commitup`
	panic("Unimplemented")
}

func (s SubcommandCommitup) PrintDefaults(output io.Writer) {
	return
}

func (s SubcommandCommitup) Parse(args []string) {
	return
}
