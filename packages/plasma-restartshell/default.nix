{ writeShellScriptBin }:
writeShellScriptBin "restartshell" ''
  systemctl --user restart plasma-plasmashell.service
''
