package main

import (
	"encoding/json"
	"errors"
	"fmt"
	"io"
	"io/fs"
	"os"
	"os/exec"
	"path/filepath"
	"strings"
	"syscall"
)

func Run(cmd string) error {
	c := exec.Command("sh", "-c", cmd)

	_, pipeW, pipeErr := os.Pipe()
	if pipeErr != nil {
		return errors.Join(pipeErr, fmt.Errorf("Run(): Failed to create output pipe"))
	}

	c.Stdout = pipeW
	c.Stderr = pipeW
	syscall.Dup2(syscall.Stdout, int(pipeW.Fd()))

	if err := c.Start(); err != nil {
		return errors.Join(err, fmt.Errorf("Run(): Failed to run `%s`", cmd))
	}
	pid := c.Process.Pid

	if err := c.Wait(); err != nil {
		if exitErr, ok := err.(*exec.ExitError); ok {
			return fmt.Errorf("Run(): Process %d exited with status %d", pid, exitErr.ExitCode())
		} else {
			return errors.Join(err, fmt.Errorf("Run(): Failed to wait process %d", pid))
		}
	}

	return nil
}

func RunCapture(cmd string) (out []byte, err error) {
	c := exec.Command("sh", "-c", cmd)
	stdout, err := c.Output()
	pid := c.ProcessState.Pid()

	if err != nil {
		if exitErr, ok := err.(*exec.ExitError); ok {
			fmt.Fprint(os.Stderr, string(exitErr.Stderr))
			return nil, fmt.Errorf("RunCapture(): Process %d exited with status %d", pid, exitErr.ExitCode())
		} else {
			return nil, errors.Join(err, fmt.Errorf("RunCapture(): Failed to wait process %d", pid))
		}
	}

	return stdout, nil
}

const NixCmd = "nix --experimental-features 'nix-command flakes' --accept-flake-config"

func Nix(args string) error {
	return Run(NixCmd + " " + args)
}

func NixCapture(args string) (out []byte, err error) {
	return RunCapture(NixCmd + " " + args)
}

func NixBuild(drv string) (output string, err error) {
	out, outErr := NixCapture("build --json " + drv)
	if outErr != nil {
		return "", errors.Join(outErr, fmt.Errorf("NixBuild(): Failed to build `%s`", drv))
	}

	var root [](map[string]any)
	if err := json.Unmarshal(out, &root); err != nil {
		return "", errors.Join(err, fmt.Errorf("NixBuild(): Malformed JSON"))
	}

	for _, p := range root {
		pathsAny, pathsAnyOk := p["outputs"].(map[string]any)
		if !pathsAnyOk {
			return "", fmt.Errorf("NixBuild(): Malformed output (pathsAny)")
		}

		var outputOk bool
		output, outputOk = pathsAny["out"].(string)
		if !outputOk {
			return "", fmt.Errorf("NixBuild(): Malformed output (output)")
		}

		break
	}

	return output, nil
}

func Cachix(args string) error {
	return Run("cachix " + args)
}

func Paths() (paths []string, err error) {
	output, outputErr := NixCapture("path-info --json result/")
	if outputErr != nil {
		return nil, errors.Join(outputErr, fmt.Errorf("Paths(): Failed to get path info of `result/`"))
	}

	var root map[string]any
	if err := json.Unmarshal(output, &root); err != nil {
		return nil, errors.Join(err, fmt.Errorf("Paths(): Malformed JSON"))
	}

	for _, v := range root {
		p, pOk := v.(map[string]any)
		if !pOk {
			return nil, fmt.Errorf("Paths(): Malformed output (p)")
		}

		refsAny, refsAnyOk := p["references"].([]any)
		if !refsAnyOk {
			return nil, fmt.Errorf("Paths(): Malformed output (refsAny)")
		}

		for _, refAny := range refsAny {
			ref, refOk := refAny.(string)
			if !refOk {
				return nil, fmt.Errorf("Paths(): Malformed output (ref)")
			}
			paths = append(paths, ref)
		}
	}

	return paths, nil
}

// Assuming `dst` exists
// `newName` is emptiable
func CopyToDir(dst string, src string, newName string) error {
	srcF, srcFErr := os.Open(src)
	if srcFErr != nil {
		return errors.Join(srcFErr, fmt.Errorf("CopyToDir(): Failed to open `%s`", src))
	}
	defer srcF.Close()

	dstFilePath := dst
	if newName == "" {
		dstFilePath = filepath.Join(dstFilePath, filepath.Base(src))
	} else {
		dstFilePath = filepath.Join(dstFilePath, newName)
	}

	// Would override files
	dstF, dstFErr := os.Create(dstFilePath)
	if dstFErr != nil {
		return errors.Join(dstFErr)
	}
	defer dstF.Close()

	srcContent, srcReadErr := io.ReadAll(srcF)
	if srcReadErr != nil {
		return errors.Join(srcReadErr, fmt.Errorf("CopyToDir(): Failed to read `%s`", src))
	}

	dstWritten, dstWriteErr := dstF.Write(srcContent)
	if dstWriteErr != nil {
		return errors.Join(srcReadErr, fmt.Errorf("CopyToDir(): Failed to write to `%s`", dstFilePath))
	}
	if dstWritten != len(srcContent) {
		return fmt.Errorf("CopyToDir(): Corrupt copy from `%s` to `%s`", src, dstFilePath)
	}

	return nil
}

func SplitAndTrim(s string, sep string) []string {
	strs := strings.Split(s, sep)
	for i, v := range strs {
		strs[i] = strings.TrimSpace(v)
	}
	return strs
}

func ReadDir(dir string) (files []string, err error) {
	d := os.DirFS(dir)
	dirEntries, dirEntriesErr := fs.ReadDir(d, ".")
	if dirEntriesErr != nil {
		return nil, errors.Join(dirEntriesErr, fmt.Errorf("ReadDir(): Failed to read `%s`", dir))
	}
	for _, e := range dirEntries {
		files = append(files, e.Name())
	}
	return files, nil
}

func FileExist(path string) bool {
	_, err := os.Stat(path)
	return err == nil
}

func CeilDiv(a, b int) int {
	return (a + b - 1) / b
}
