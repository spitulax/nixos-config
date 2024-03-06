# Neovim

My [Neovim](https://github.com/neovim/neovim) config uses [NvChad](https://github.com/NvChad/NvChad) for the "base" config.
NvChad sets up [lazy.nvim](https://github.com/folke/lazy.nvim) which is the plugin manager, and also enabling sensible options out of the box.
It's also very simple and costumizable. It's basically just a regular Neovim config.

## Configuration

All configurations should be done from [./custom](./custom).

### Adding plugins

Add a new table to the `M` table in [`plugins.lua`](./custom/plugins.lua).
By default, plugins are lazy loaded. Don't forget to add the load condition or add this for the default load condition!
```lua
init = function()
    lazy_load("<plugin name>")
end,
```

### Config location

- Neovim-specific configs are located in [`init.lua`](./custom/init.lua).
- NvChad-specific configs are located in [`chadrc.lua`](./custom/chadrc.lua).
- General mappings are configured in [`mappings.lua`](./custom/mappings.lua).
- Highlights are configured in [`highlight.lua`](./custom/highlight.lua).
- [`plugins.lua`](./custom/plugins.lua) see above.
- [`ui.lua`](./custom/ui.lua) is used to modify NvChad builtin tabline and statusline.

### Configuring plugins

Plugin-specific configs are located in separate files for each plugins in [`configs/`](./custom/configs/) directory.
Each file should return a table that optionally contains:
- `setup`: a function that will be called when the plugin is loaded.
- `opts`: a table that will override the plugin's default settings.
- `mappings`: a table that contains mappings that will be loaded alongside the plugin [(details)](#configuring-mappings).

You must explicitly state in [`plugins.lua`](./custom/plugins.lua) that the plugin will use any of these tables.
- **To use `setup`:**
```lua
config = function(_, opts)
    -- the parameter `opts` is the `opts` table if passed
    -- <module> should be located in ./custom/configs
    -- you can add any parameters in the config file as you want and pass the argumants here if needed
    require("<module>").setup(...)
end,
```
- **To use `opts`:**
```lua
opts = function()
    return require("<module>").opts
end,
```
- **To use `mappings`:**
See [here](#configuring-mappings).

### Configuring mappings

- Define your mappings in a file in [`configs/`](./custom/configs/) directory.
- Add this to the plugin table in [`plugins.lua`](./custom/plugins.lua)
```lua
init = function()
    load_mappings("<config filename without .lua>")
end,
```
- In [`mappings.lua`](./custom/mappings.lua) go to bottom and find `mappings` table. Add the same string as the `load_mappings` argument to the table.

## TODO

- [ ] List the plugins that are installed for documentation and future reference
- [ ] vim-visual-multi keybinding isn't configured. I remember it was broken or it didn't play well with other keybindings. I may replace it with another plugin
