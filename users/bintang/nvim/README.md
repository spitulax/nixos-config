# Neovim

My [Neovim](https://github.com/neovim/neovim) config uses [NvChad](https://github.com/NvChad/NvChad/tree/v2.5) for the "base" config.
NvChad also sets up [lazy.nvim](https://github.com/folke/lazy.nvim) for the plugin manager.

## Configuration

### Configuring key mappings

- Define your mappings in [`mappings.lua`](./lua/mappings.lua) to the appropriate section.

### Adding plugins

Add a new table to [`plugins.lua`](./lua/plugins/init.lua) containing the plugin definition with the [Lazy spec](https://github.com/folke/lazy.nvim?tab=readme-ov-file#-plugin-spec).
By default, plugins are lazy loaded. Don't forget to add the load condition or add this for the default load condition!
```lua
{
  -- ...
  event = "User FilePost",
  -- ...
}
```

### Config location

- Neovim-specific configs are located in [`init.lua`](./lua/init.lua).
- NvChad-specific configs are located in [`chadrc.lua`](./lua/chadrc.lua) defined in [`nvconfig.lua`](https://github.com/NvChad/NvChad/blob/v2.5/lua/nvconfig.lua).
- Mappings are configured in [`mappings.lua`](./lua/mappings.lua).
- Highlights are configured in [`highlight.lua`](./lua/highlight.lua).
- [`plugins.lua`](./lua/plugins/init.lua) see above.
- [`statusline.lua`](./lua/statusline.lua) is used to modify NvChad builtin statusline.
- [`tabufline.lua`](./lua/tabufline.lua) is used to modify NvChad builtin tabline.

### Configuring plugins

Plugin-specific configs are located in separate files for each plugins in [`configs/`](./lua/configs) directory.
Each file should return a table that optionally contains:
- `config`: a function that should be called when the plugin is loaded.
- `opts`: a function that returns a table that will override the plugin's default settings.

You must explicitly state in [`plugins.lua`](./lua/plugins/init.lua) that the plugin will use any of these tables.

- **To use `config`:**

```lua
{
  -- ...
  -- the function should accept arguments defined in the Lazy spec
  -- <module> should be located in ./lua/configs so the module name is prepended with `configs.`
  config = require("<module>").config,
  -- ...
}
```

or alternatively,

```lua
{
  -- ...
  -- you can add as many parameters to the module as you want and pass the arguments here if needed
  config = function(_, opts)
    local something = 42
    require("<module>").config(something, opts)
  end,
  -- ...
}
```

- **To use `opts`:**

```lua
{
  -- ...
  opts = require("<module>").opts,
  -- ...
}
```

## TODO

- [ ] List the plugins that are installed for documentation and future reference
- [ ] vim-visual-multi keybinding isn't configured. I remember it was broken or it didn't play well with other keybindings. I may replace it with another plugin
