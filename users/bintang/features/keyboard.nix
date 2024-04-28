{
  # Nah don't do this. Some apps don't read the environment variable. Just one file in your home directory won't hurt you
  # home.sessionVariables.XCOMPOSEFILE = "$XDG_CONFIG_HOME/XCompose";
  # home.file.".config/XCompose".source = ./XCompose;
  home.file.".XCompose".source = ./XCompose;
}
