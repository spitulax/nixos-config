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

bind \ca 'cdi; commandline -f repaint'
bind -Minsert \ca 'cdi; commandline -f repaint'
bind \cs 'echo; cdh; commandline -f repaint'
bind -Minsert \cs 'echo; cdh; commandline -f repaint'
bind \cz 'cd -; commandline -f repaint'
bind -Minsert \cz 'cd -; commandline -f repaint'
bind \cx 'cd ..; commandline -f repaint'
bind -Minsert \cx 'cd ..; commandline -f repaint'
bind \cq 'exit'
bind -Minsert \cq 'exit'
bind \cc kill-whole-line repaint
bind -Minsert \cc kill-whole-line repaint

######
