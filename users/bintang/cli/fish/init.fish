### FISH INIT ###

# Remove fish intro
function fish_greeting
  printf '\033[1;34m-*-   Welcome back! -*-\n'
  crt fish --verbose
  printf '\033[0m\n'
end

# Vi mode
fish_vi_key_bindings

# Cursor appearance indicates mode
set fish_cursor_default     block      blink
set fish_cursor_insert      line       blink
set fish_cursor_replace_one underscore blink
set fish_cursor_visual      block
set -g fish_vi_force_cursor 1 # Set this to force cursor shape in tmux

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

if [ "$fish_key_bindings" = "fish_vi_key_bindings" ];
  bind -Minsert ! __history_previous_command
  bind -Minsert '$' __history_previous_command_arguments
else
  bind ! __history_previous_command
  bind '$' __history_previous_command_arguments
end

######

### KEYBINDINGS ###

for mode in default insert
  bind --mode $mode \ca 'cdi; commandline -f repaint'
  bind --mode $mode \cs 'echo; cdh; commandline -f repaint'
  bind --mode $mode \cz 'cd -; commandline -f repaint'
  bind --mode $mode \cx 'cd ..; commandline -f repaint'
  bind --mode $mode \cq 'exit'
  bind --mode $mode \cc kill-whole-line repaint

  # fzf.fish
  bind --mode $mode \eh '_fzf_search_history'
  # ctrl-alt-f - files
  # ctrl-alt-l - git log
  # ctrl-alt-s - git status
  # ctrl-alt-p - processes
  # ctrl-v     - variable
end

######

### HELPER FUNCTIONS ###

function extract
  for archive in $argv
    if test -f $archive
      switch $archive
      case '*.tar.bz2'
        tar xvjf $archive
      case '*.tar.gz'
        tar xvzf $archive
      case '*.bz2'
        bunzip2 $archive
      case '*.rar'
        rar x $archive
      case '*.gz'
        gunzip $archive
      case '*.tar'
        tar xvf $archive
      case '*.tbz2'
        tar xvjf $archive
      case '*.tgz'
        tar xvzf $archive
      case '*.zip'
        unzip $archive
      case '*.Z'
        uncompress $archive
      case '*.7z'
        7z x $archive
      case '*'
        echo "Could not extract $archive"
      end
    else
      echo "Could not extract $archive"
    end
  end
end

######
