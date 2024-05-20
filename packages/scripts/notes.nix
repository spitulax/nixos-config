{ writeShellScriptBin }:
writeShellScriptBin "notes" ''

cd $NOTES_DIR
nvim

''
