{ writeShellScriptBin }:
writeShellScriptBin "tmuxs" ''

SOCK=$(upfind . -name .tmux* 2>/dev/null)
SOCKNAME=".tmux_$(pwd | rev | cut -d'/' -f1 | rev)"
if [[ -n "$SOCK" ]]; then
  tmux -S "$SOCK" "$@"
else
  echo "Creating $SOCKNAME"
  tmux -S "$SOCKNAME" "$@"
fi

''
