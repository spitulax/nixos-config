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

# Runs tldr of the command under the cursor
function __tldr_currentline
  if test -n (commandline -b)
    commandline -C 0
    commandline -i "tldr "
    commandline -f execute
  else
    commandline -f repaint
  end
end

# Search a file and view/edit it in $EDITOR
function __fzf_edit_file
  _fzf_search_directory
  if test -n (commandline -b)
    commandline -C 0
    commandline -i "$EDITOR "
    commandline -f execute
  else
    commandline -f repaint
  end
end

# Run typed command paged
function __run_page
  commandline -i " | less"
  commandline -f execute
end

######

### KEYBINDINGS ###

function __run_cmdline
  for cmd in $argv
    eval $cmd
  end
  commandline -f repaint
end

for mode in default insert
  bind --mode $mode ! __history_previous_command
  bind --mode $mode '$' __history_previous_command_arguments
  bind --mode $mode \ca "__run_cmdline cdi"
  bind --mode $mode \cs "__run_cmdline echo cdh"
  bind --mode $mode \cz "__run_cmdline 'cd -'"
  bind --mode $mode \cx "__run_cmdline 'cd ..'"
  bind --mode $mode \cf "__run_cmdline echo fg"
  bind --mode $mode \cj "__run_cmdline echo jobs"
  bind --mode $mode \cq exit
  bind --mode $mode \cc kill-whole-line repaint
  bind --mode $mode \cp __run_page

  if [ (command -v yazi) ]
    bind --mode $mode \cy yy
  end

  if [ (command -v tldr) ]
    bind --mode $mode \eh __tldr_currentline
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
