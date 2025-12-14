// THIS IS A JOKE BUT EVERYTHING IS BETTER THAN BASH
// Programs needed:
// For helper: nix, cachix, git, nom (optional)
// For update scripts: nix, gh (authorised), jq, coreutils

package main

import (
	"flag"
	"fmt"
	"io"
	"os"
	"os/signal"
	"syscall"
)

const DefaultCachixName = "spitulax"

var prog Prog

func main() {
	prog = NewProg()
	prog.Run()
}

func init() {
	c := make(chan os.Signal, 1)
	signal.Notify(c, os.Interrupt, syscall.SIGTERM)
	go func() {
		<-c

		// Restore cursor visibility
		fmt.Print("\033[?25h\n")

		os.Exit(1)
	}()
}

type Prog struct {
	subcommands []Subcommand
}

func NewProg() (p Prog) {
	// Some subcommands are retired in this mypkgs, but I'm too lazy to mark the files individually.
	p.subcommands = []Subcommand{
		// NewSubcommandBuild(),
		// NewSubcommandCommitup(),
		NewSubcommandNew(),
		// NewSubcommandPartup(),
		// NewSubcommandPushinput(),
		// NewSubcommandPushpkgs(),
		NewSubcommandUp(),
		NewSubcommandUpinput(),
		NewSubcommandUplist(),
		NewSubcommandUpscript(),
	}

	return p
}

func (p *Prog) Run() {
	flag.Usage = func() {
		out := flag.CommandLine.Output()
		fmt.Fprintf(out, "Usage of %s:\n", os.Args[0])
		flag.CommandLine.PrintDefaults()
		fmt.Fprintln(out, "\nSubcommands: (Run `--help` for each subcommand)")
		for _, s := range p.subcommands {
			fmt.Fprintf(out, "\033[1;34m%s\033[0m", s.Name())
			fmt.Fprintf(out, ": %s\n", s.Usage())
		}
	}

	if len(os.Args) < 2 {
		fmt.Fprintln(os.Stderr, "Expected a subcommand")
		flag.CommandLine.SetOutput(os.Stderr)
		flag.Usage()
		os.Exit(2)
	}

	flag.Parse()

	subcommand := os.Args[1]
	for _, s := range p.subcommands {
		if subcommand == s.Name() {
			s.Parse(os.Args[2:])
			if err := s.Run(); err != nil {
				fmt.Fprintln(os.Stderr, err)
				fmt.Fprintf(os.Stderr, "Unable to run `%s`\n", subcommand)
				os.Exit(2)
			}
			return
		}
	}

	fmt.Fprintf(os.Stderr, "Unknown subcommand `%s`\n", subcommand)
	flag.CommandLine.SetOutput(os.Stderr)
	flag.Usage()
	os.Exit(2)
}

type Subcommand interface {
	Name() string
	Usage() string
	Run() error
	PrintDefaults(output io.Writer)
	Parse(args []string)
}
