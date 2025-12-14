package main

import (
	"errors"
	"fmt"
	"os"
	"os/exec"
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

const NixCmd = "nix --experimental-features 'nix-command flakes' --accept-flake-config"

func Nix(args string) error {
	return Run(NixCmd + " " + args)
}
