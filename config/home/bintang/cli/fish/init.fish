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

function where -a prog -w which
  realpath (which $prog)
end

function upmake -a target -w make
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
