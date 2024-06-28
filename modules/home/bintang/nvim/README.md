# Neovim

My [Neovim] config uses [NvChad] for the "base" config. NvChad also sets up [lazy.nvim] for the
plugin manager.

## Configuration

### Configuring key mappings

A mapping should be defined in [`mappings.lua`] if it's a general mapping, for plugin mapping it
should be defined in the plugin's config file. For more information see [here](#mappings).

### Adding plugins

Add a new table to [`plugins.lua`] containing the plugin definition with the
[Lazy spec](https://github.com/folke/lazy.nvim?tab=readme-ov-file#-plugin-spec). By default, plugins
are lazy loaded. Don't forget to add the load condition or add this for the default load condition!

```lua
{
  -- ...
  event = "User FilePost",
  -- ...
}
```

### Config location

- Neovim-specific configs are located in [`options.lua`].
- NvChad-specific configs are located in [`chadrc.lua`].
- Mappings are configured in [`mappings.lua`].
- Highlights are configured in [`highlight.lua`].
- Autocommands are configured in [`autocmds.lua`].
- For a detail about [`plugins.lua`] see above.
- [`statusline.lua`] is used to modify NvChad builtin statusline.
- [`tabufline.lua`] is used to modify NvChad builtin tabline.
- [`utils.lua`] contains helper functions for the neovim config and [`classes.lua`] contains some
  types for documentation purpose.

### Configuring plugins

Plugin-specific configs are located in separate files for each plugins in
[`configs/`](./lua/configs) directory. Each file should return a table of type `PluginConfig`, see
[`classes.lua`].

You must explicitly state in [`plugins/init.lua`] that the plugin will use a field of
`PluginConfig`.

#### `config`

```lua
{
  -- ...
  -- the function should accept arguments defined in the Lazy spec
  -- <module> should be located in ./lua/configs/ so the module name is prepended with `configs.`
  config = require("<module>").config,
  -- ...
}
```

#### `opts`

```lua
{
  -- ...
  opts = require("<module>").opts,
  -- ...
}
```

#### `mappings`

Once you define `mappings` in plugin config. This will not be referenced in [`plugins/init.lua`],
instead you must add the module name of the config to the `plugins` table in [`mappings.lua`].

## `lazy-lock.json`

This is just to make sure the Lazy version lock is available from this repo for reproducibility.
It's not the best solution since it makes running action that modifies the lock file cumbersome. But
I've made `lazyup` script to specifically provide normal environment so that Lazy could write into
the lock file in `~/.config/nvim` and then updating the lock file in this repo.

## TODO

- [ ] List the plugins that are installed for documentation and future reference
- [ ] vim-visual-multi keybinding isn't configured. I remember it was broken or it didn't play well
      with other keybindings. I may replace it with another plugin

[Neovim]: https://github.com/neovim/neovim
[NvChad]: https://github.com/NvChad/NvChad/tree/v2.5
[lazy.nvim]: https://github.com/folke/lazy.nvim
[`mappings.lua`]: ./lua/mappings.lua
[`plugins.lua`]: ./lua/plugins/init.lua
[`options.lua`]: ./lua/options.lua
[`chadrc.lua`]: ./lua/chadrc.lua
[`highlight.lua`]: ./lua/highlight.lua
[`autocmds.lua`]: ./lua/autocmds.lua
[`statusline.lua`]: ./lua/statusline.lua
[`tabufline.lua`]: ./lua/tabufline.lua
[`utils.lua`]: ./lua/utils.lua
[`classes.lua`]: ./lua/classes.lua
[`plugins/init.lua`]: ./lua/plugins/init.lua
