local slow_format_filetypes = {}

return {
  opts = function()
    return {
      formatters = {
        odinfmt = {
          command = "odinfmt",
          args = { "-stdin" },
        },
      },

      formatters_by_ft = {
        go = { "gofmt" },
        rust = { "rustfmt" },
        nix = { "nixpkgs_fmt" },
        gdscript = { "gdformat" },
        c = { "clang-format" },
        cpp = { "clang-format" },
        odin = { "odinfmt" },
        javascript = { "denofmt" },
        typescript = { "denofmt" },
        json = { "denofmt" },
        markdown = { "denofmt" },
        lua = { "stylua" },
      },

      format_on_save = function(bufnr)
        if slow_format_filetypes[vim.bo[bufnr].filetype] then
          return
        end
        local function on_format(err)
          if err and err:match("timeout$") then
            slow_format_filetypes[vim.bo[bufnr].filetype] = true
          end
        end

        return { timeout_ms = 200, lsp_fallback = false }, on_format
      end,

      format_after_save = function(bufnr)
        if not slow_format_filetypes[vim.bo[bufnr].filetype] then
          return
        end
        return { lsp_fallback = false }
      end,

      log_level = vim.log.levels.OFF,
    }
  end,
}
