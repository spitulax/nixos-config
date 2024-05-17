{ writeShellScriptBin }:
writeShellScriptBin "tmuxs" ''

SOCK=$(upfind . -name .tmux 2>/dev/null)
if [[ -n "$SOCK" ]]; then
  tmux -S "$SOCK" "$@"
else
  echo "Creating .tmux file"
  tmux -S .tmux "$@"
fi

''
