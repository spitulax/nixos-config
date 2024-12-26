### KEYBIND FUNCTIONS ###

# Enable !! and !$ command
function __history_previous_command
  switch (commandline -t)
  case "!"
    commandline -t $history[1]
    commandline -f repaint
  case "*"
    commandline -i !
  end
end
function __history_previous_command_arguments
  switch (commandline -t)
  case "!"
    commandline -t ""
    commandline -f history-token-search-backward
  case "*"
    commandline -i '$'
  end
end

function __delete_prompt \
-d "delete/reset the prompt"
  commandline -r ''
  commandline -f repaint
end

function __run_cmdline \
-d "run commands without changing the current prompt"
  argparse -s n h -- $argv
  or set -l usage
  set -ql _flag_h; and set -l usage
  if set -ql usage
    echo "$(status current-function) [-n] <command>"
    echo "    -n        Don't prepend output with newline"
    commandline -f repaint
    return
  end

  set -ql _flag_n; or echo
  eval $argv
  commandline -f repaint
end

function __run_from_prompt \
-d "run a command based on what's written in the prompt"
  argparse -s h n p -- $argv
  or set -l usage
  set -ql _flag_h; and set -l usage
  if set -ql usage
    echo "$(status current-function) [-n|p] <command>"
    echo "Any occurence of '\$prompt' in `command` will be substituted for the prompt"
    echo "    -n        Don't prepend output with newline"
    echo "    -p        Create new prompt"
    commandline -f repaint
    return
  end

  set -ql _flag_n; or echo

  set -l prompt (commandline -b)
  if test -z $prompt
    commandline -f repaint
  else
    __run_cmdline -n (eval "echo -n \"$argv\"")
  end

  if set -ql _flag_p
    __delete_prompt
  end
end

function __fzf_edit_file \
-d 'search a file and view/edit it in $EDITOR'
  _fzf_search_directory
  or return
  __run_from_prompt -np "$EDITOR \$prompt"
end

######

### KEYBINDINGS ###

for mode in default insert
  bind --mode $mode ! __history_previous_command
  bind --mode $mode '$' __history_previous_command_arguments
  bind --mode $mode \ca "__run_cmdline -n cdi"
  bind --mode $mode \cs "__run_cmdline cdh"
  bind --mode $mode \cz "__run_cmdline -n cd -"
  bind --mode $mode \cx "__run_cmdline -n cd .."
  bind --mode $mode \cf "__run_cmdline fg"
  bind --mode $mode \cj "__run_cmdline jobs"
  bind --mode $mode \cq exit
  bind --mode $mode \cc __delete_prompt
  bind --mode $mode \cp "__run_from_prompt -p '\$prompt &| less'"
  bind --mode $mode \et "__run_from_prompt 'builtin type \$prompt'"

  if [ (command -v yazi) ]
    bind --mode $mode \cy yy
  end

  if [ (command -v tldr) ]
    bind --mode $mode \eh "__run_from_prompt 'tldr \$prompt'"
  end

  # fzf.fish
  bind --mode $mode \e\ce __fzf_edit_file
  # ctrl-alt-f - files
  # ctrl-alt-l - git log
  # ctrl-alt-s - git status
  # ctrl-alt-p - processes
  # ctrl-v     - variable

  # atuin
  if [ (command -v atuin) ]
    bind --mode $mode \cr _atuin_search
    bind --mode $mode \er _atuin_bind_up
  end
end

######
