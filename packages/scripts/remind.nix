{ writeShellScriptBin }:
writeShellScriptBin "remind" ''

[ $# -lt 1 ] && echo "Usage: remind <command>" && exit 1
$@ && notify-send -u critical DONE! "$(echo $@)" || notify-send -u critical FAILED! "$(echo $@)"

''
