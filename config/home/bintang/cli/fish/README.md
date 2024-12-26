# Fish

## Aliases

See [`default.nix`](./default.nix).

## Keybindings

### Builtins

These are keybinds built into fish that I find useful.

- alt-l - runs `ls` in the current directory or the directory written in the command line, in this
  case I aliased `ls` to `eza`
- alt-s - prepends current or last comand with `sudo`
- f1 - opens man page for current command
- alt-e - opens the current command line in $EDITOR
- alt-w - prints a short description of the command under the cursor

### Custom

_NOTE: these keybindings are applied for both normal/default and insert mode_

- ctrl-a - runs zoxide's `zi/cdi` to interactively cd into a directory
- ctrl-c - deletes the current line
- ctrl-f - resumes latest background job
- ctrl-j - lists background jobs
- ctrl-p - runs a command and page its output
- ctrl-q - quits fish
- ctrl-s - quickly navigate to the directories you have visited before
- ctrl-y - runs yazi
- ctrl-z - cd into previous directory (`cd -`)
- alt-h - runs tldr for the command under the cursor
- alt-t - runs type for the command under the cursor

### [fzf.fish](https://github.com/PatrickF1/fzf.fish)

- ctrl-alt-f - search files
- ctrl-alt-l - fzf git log
- ctrl-alt-s - fzf git status
- ctrl-alt-p - search processes
- ctrl-v - search variables
- ctrl-alt-e - search a file and view/edit it in $EDITOR

## [atuin](https://github.com/atuinsh/atuin)

- ctrl-r - search all history
- alt-r - search current session's history
