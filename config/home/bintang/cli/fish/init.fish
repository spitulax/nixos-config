### FISH INIT ###

# Change fish intro
function fish_greeting
  echo -e '\033[1;34m-*-   Welcome back! -*-'
  if [ (command -v crt) ]
    if [ (command -v atuin) ]
      crt atuin --verbose
    else
      crt fish --verbose
    end
  end
  echo -e '\033[0m'
end

# Vi mode
fish_vi_key_bindings

# Cursor appearance indicates mode
set fish_cursor_default     block      blink
set fish_cursor_insert      line       blink
set fish_cursor_replace_one underscore blink
set fish_cursor_visual      block
set -g fish_vi_force_cursor 1 # Set this to force cursor shape in tmux

# Atuin
if [ (command -v atuin) ]
  set -gx ATUIN_NOBIND "true"
  atuin init fish | source
end

### HELPER FUNCTIONS ###

function where -a prog -w which \
-d "print the exact location of a program"
  realpath (which $prog)
end

function upmake -a target -w make \
-d "`make` that searches for Makefile in parent directories"
  make -C (dirname (upfind . -name Makefile)) $target
end

if [ (command -v yazi) ]
  function yy
    set tmp (mktemp -t "yazi-cwd.XXXXX")
    yazi $argv --cwd-file="$tmp"
    if set cwd (env cat -- "$tmp"); and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
      builtin cd -- "$cwd"
    end
    env rm -f -- "$tmp"
  end
end

######
