# Neovim

My huge [Neovim] config. Uses [lazy.nvim] package manager and [NvChad] for UI stuff.

## Structure

- [`internals/`]: Turns sort of declarative configs into something neovim can use.
  - [`classes.lua`](./lua/internals/classes.lua): Class definition, documentation for objects.
  - [`for_lazy.lua`](./lua/internals/for_lazy.lua): Importing plugin specs to Lazy (kind of hacky).
  - [`languages.lua`](./lua/internals/languages.lua): Parses `LanguageConfig` objects defined in
    [`languages/`].
  - [`mappings.lua`](./lua/internals/mappings.lua): Parses [`mappings.lua`] and also `mappings`
    field of `PluginConfig` objects defined in [`plugins/`].
  - [`plugins.lua`](./lua/internals/plugins.lua): Parses `PluginConfig` objects defined in
    [`plugins/`].
- [`languages/`]: Language options, e.g. LSPs, Formatters, Autocommands. Each file is named
  `<filetype>.lua` and returns `LanguageConfig` object.
- [`plugins/`]: Plugin spec definitions. Each file returns `PluginConfig` object. Also contains a
  short description of the plugin.
- [`ui/`]: Highlights, statusline, and tabufline config. Used only in [`chadrc.lua`].
- [`autocmds.lua`]: User defined autocommands
- [`chadrc.lua`]: NvChad UI config
- [`mappings.lua`]: General mapping definitions.
- [`options.lua`]: User defined `init.lua`.
- [`utils.lua`]: Utility functions.

## Configuration

### Configuring key mappings

A mapping should be defined in [`mappings.lua`] if it's a general mapping, for plugin mapping Define
`mappings` in `PluginConfig` object.

### Adding plugins

Add a new file into [`plugins/`] that returns `PluginConfig` object. By default, plugins are lazy
loaded. Don't forget to add the load condition or change `PluginConfig.spec.event` to
`"User FilePost"` for the default load condition!

## `lazy-lock.json`

This is just to make sure the Lazy version lock is available from this repo for reproducibility.
It's not the best solution since it makes running action that modifies the lock file cumbersome. But
I've made `lazyup` script to specifically provide normal environment so that Lazy could write into
the lock file in `~/.config/nvim` and then updating the lock file in this repo.

## TODO

- [ ] vim-visual-multi keybinding isn't configured. I remember it was broken or it didn't play well
      with other keybindings. I may replace it with another plugin

[Neovim]: https://github.com/neovim/neovim
[NvChad]: https://github.com/NvChad/ui
[lazy.nvim]: https://github.com/folke/lazy.nvim
[`internals/`]: ./lua/internals
[`languages/`]: ./lua/languages
[`plugins/`]: ./lua/plugins
[`ui/`]: ./lua/ui
[`autocmds.lua`]: ./lua/autocmds.lua
[`chadrc.lua`]: ./lua/chadrc.lua
[`mappings.lua`]: ./lua/mappings.lua
[`options.lua`]: ./lua/options.lua
[`utils.lua`]: ./lua/utils.lua
