### FISH INIT ###

# Change fish intro
function fish_greeting
  set_color -o blue
  echo '-*-   Welcome back! -*-'
  if command -q crt
    if command -q atuin
      crt atuin --verbose
    else
      crt fish --verbose
    end
  end
  set_color normal
  echo
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
if command -q atuin
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

if command -q yazi
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
