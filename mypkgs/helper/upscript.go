package main

import (
	"encoding/json"
	"errors"
	"flag"
	"fmt"
	"io"
	"os"
	"os/exec"
	"path/filepath"
	"time"
)

const DefaultMaxThreads = 8

// `pkgs` and `flakes` are comma-separated
type UpscriptOpts struct {
	pkgs       *string
	flakes     *string
	force      *bool
	flakesOnly *bool
	pkgsOnly   *bool
	skipExist  *bool
	maxThreads *uint
}

func NewUpscriptOpts(f *flag.FlagSet) (o UpscriptOpts) {
	o.pkgs = f.String("pkgs", "", "One or more packages to update (comma-separated)")
	o.flakes = f.String("flakes", "", "One or more flakes to update (comma-separated)")
	o.force = f.Bool("force", false, "Update even if the found version is the same as the old version")
	o.flakesOnly = f.Bool("flakes-only", false, "Only update the flakes")
	o.pkgsOnly = f.Bool("pkgs-only", false, "Only update the packages")
	o.skipExist = f.Bool("skip-exist", false, "Skip directories where pkg.json or flake.json already exists")
	o.maxThreads = f.Uint("max-threads", DefaultMaxThreads, "Maximum amount of scripts to run at once")
	return o
}

type SubcommandUpscript struct {
	flags *flag.FlagSet
	UpscriptOpts
}

func NewSubcommandUpscript() (s SubcommandUpscript) {
	s.flags = NewFlagSet(s.Name())
	s.UpscriptOpts = NewUpscriptOpts(s.flags)
	return s
}

func (s SubcommandUpscript) Name() string {
	return "upscript"
}

func (s SubcommandUpscript) Usage() string {
	return "Run the update script of maintained packages and flakes"
}

func (s SubcommandUpscript) Run() error {
	if err := Upscript(s.UpscriptOpts); err != nil {
		return err
	}

	return nil
}

func (s SubcommandUpscript) PrintDefaults(output io.Writer) {
	s.flags.PrintDefaults()
}

func (s SubcommandUpscript) Parse(args []string) {
	s.flags.Parse(args)
}

func Upscript(opts UpscriptOpts) error {
	fmt.Println("\033[1;34mRunning update scripts...\033[0m")

	relyOnOpts := *opts.flakes != "" || *opts.pkgs != ""

	var buildPkgs, buildFlakes bool
	if relyOnOpts {
		buildPkgs = *opts.pkgs != ""
		buildFlakes = *opts.flakes != ""
	} else if !(*opts.pkgsOnly || *opts.flakesOnly) {
		buildPkgs, buildFlakes = true, true
	} else {
		buildPkgs = *opts.pkgsOnly
		buildFlakes = *opts.flakesOnly
	}

	// flakes operations should be first

	if buildFlakes {
		var flakesScripts string
		var flakes []string

		fmt.Println("Building `flakes-update-scripts`...")
		var drvErr error
		flakesScripts, drvErr = NixBuild(".#flakes-update-scripts")
		if drvErr != nil {
			return drvErr
		}

		if *opts.flakes != "" {
			flakes = SplitAndTrim(*opts.flakes, ",")
		} else if !relyOnOpts {
			var err error
			flakes, err = ReadDir(flakesScripts)
			if err != nil {
				return err
			}
		}

		fmt.Printf("\033[1;32mRunning %d flake update scripts...\033[0m\n", len(flakes))
		if err := UpMany(opts, UpFlake, flakesScripts, flakes); err != nil {
			return err
		}
	}

	if buildPkgs {
		var pkgsScripts string
		var pkgs []string

		fmt.Println("Building `pkgs-update-scripts`...")
		var drvErr error
		pkgsScripts, drvErr = NixBuild(".#pkgs-update-scripts")
		if drvErr != nil {
			return drvErr
		}

		if *opts.pkgs != "" {
			pkgs = SplitAndTrim(*opts.pkgs, ",")
		} else if !relyOnOpts {
			var err error
			pkgs, err = ReadDir(pkgsScripts)
			if err != nil {
				return err
			}
		}

		fmt.Printf("\033[1;32mRunning %d package update scripts...\033[0m\n", len(pkgs))
		if err := UpMany(opts, UpPkg, pkgsScripts, pkgs); err != nil {
			return err
		}
	}

	return nil
}

type UpKind uint8

func ContainingDir(kind UpKind) string {
	switch kind {
	case UpFlake:
		return "flakes"
	case UpPkg:
		return "pkgs"
	}
	panic("Unreachable")
}

func UpFullName(kind UpKind, name string) string {
	return fmt.Sprintf("%s:%s", ContainingDir(kind), name)
}

const (
	UpFlake UpKind = iota
	UpPkg
)

type UpScriptState uint8

const (
	Done UpScriptState = iota
	Completing
)

type UpScriptOneData struct {
	err      chan error
	fullName string
	state    UpScriptState
}

const WaitTimeout = 100 * time.Millisecond

// TODO: Better visualisation
func UpMany(opts UpscriptOpts, kind UpKind, scriptDir string, names []string) error {
	maxThreads := int(*opts.maxThreads)
	datas := make([]UpScriptOneData, maxThreads)
	for i := range datas {
		datas[i].err = make(chan error)
		datas[i].state = Done
	}

	namesIdx := 0
	done := 0
	for done < len(names) {
		for i := range datas {
			data := &datas[i]
			switch data.state {
			case Done:
				if namesIdx < len(names) {
					name := names[namesIdx]
					data.fullName = UpFullName(kind, name)
					data.state = Completing
					namesIdx++
					go func(d *UpScriptOneData, opts UpscriptOpts, kind UpKind, name string, scriptDir string) {
						d.err <- UpOne(opts, kind, name, scriptDir)
					}(data, opts, kind, name, scriptDir)
				}
			case Completing:
				select {
				case err := <-data.err:
					if err != nil {
						return errors.Join(err, fmt.Errorf("UpScriptEnv.Wait(): Failed to update %s", data.fullName))
					} else {
						data.state = Done
						done++
					}
				case <-time.After(WaitTimeout):
					break
				}
			}
		}
	}

	return nil
}

func UpOne(opts UpscriptOpts, kind UpKind, name string, scriptDir string) error {
	containingDir := ContainingDir(kind)

	dir := filepath.Join(containingDir, name)
	if !FileExist(dir) {
		return fmt.Errorf("UpOne(): `%s` does not exist", dir)
	}

	var jsonPath string
	switch kind {
	case UpFlake:
		jsonPath = filepath.Join(dir, "flake.json")
	case UpPkg:
		jsonPath = filepath.Join(dir, "pkg.json")
	}

	fullName := UpFullName(kind, name)

	if *opts.skipExist && FileExist(jsonPath) {
		fmt.Printf("\033[30mSkipped %s\033[0m\n", fullName)
		return nil
	}

	fmt.Printf("\033[1mUpdating %s...\033[0m\n", fullName)

	oldVer := ""
	if FileExist(jsonPath) {
		jsonData, jsonErr := os.ReadFile(jsonPath)
		if jsonErr != nil {
			return errors.Join(jsonErr, fmt.Errorf("UpOne(): Failed to read `%s`", jsonPath))
		}
		switch kind {
		case UpFlake:
			rev, revErr := GetJsonObjectString(jsonData, "rev")
			if revErr != nil {
				return revErr
			}
			oldVer = rev
		case UpPkg:
			origVersion, origVersionErr := GetJsonObjectString(jsonData, "orig_version")
			if origVersionErr != nil {
				return origVersionErr
			}
			oldVer = origVersion
		}
	} else {
		file, fileErr := os.OpenFile(jsonPath, os.O_CREATE, 0644)
		if fileErr != nil {
			return errors.Join(fileErr, fmt.Errorf("UpOne(): Failed to create `%s`", jsonPath))
		}
		file.Close()

		git := exec.Command("git", "add", jsonPath)
		_, gitErr := git.Output()
		if git.ProcessState.ExitCode() != 0 {
			fmt.Fprint(os.Stderr, string(gitErr.(*exec.ExitError).Stderr))
			return fmt.Errorf("UpOne(): Failed to stage `%s`", jsonPath)
		}
	}

	cmd := exec.Command(filepath.Join(scriptDir, name), oldVer)

	cmd.Env = append(cmd.Env, os.Environ()...)
	if *opts.force {
		cmd.Env = append(cmd.Env, "FORCE=1")
	} else {
		cmd.Env = append(cmd.Env, "FORCE=0")
	}

	// TODO: Download processes are not displayed
	// They also run concurrently which makes them harder to display
	stdout, cmdErr := cmd.Output()
	if cmdErr != nil {
		if _, ok := cmdErr.(*exec.ExitError); !ok {
			return errors.Join(cmdErr, fmt.Errorf("UpOne(): Failed to run update script %s", fullName))
		}
	}

	exit := cmd.ProcessState.ExitCode()
	switch exit {
	case 0:
		fmt.Printf("Updated %s\n", fullName)
		if err := os.WriteFile(jsonPath, stdout, 0o644); err != nil {
			return errors.Join(err, fmt.Errorf("UpOne(): Failed to write to `%s`", jsonPath))
		}
	case 200:
		break
	default:
		fmt.Fprint(os.Stderr, string(cmdErr.(*exec.ExitError).Stderr))
		return fmt.Errorf("UpOne(): Update script %s exited with status %d", fullName, exit)
	}

	return nil
}

func GetJsonObjectString(data []byte, key string) (value string, err error) {
	var rootAny map[string]any
	if err := json.Unmarshal(data, &rootAny); err != nil {
		return "", errors.Join(err, fmt.Errorf("GetJsonObjectString(): Malformed JSON"))
	}
	val, valOk := rootAny[key].(string)
	if !valOk {
		return "", fmt.Errorf("GetJsonObjectString(): Malformed output (val)")
	}

	return val, nil
}
