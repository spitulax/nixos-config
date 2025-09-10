--- Auto-formatter.

local languages = require("internals.languages")

local lsp_fts = languages.fts_format_with_lsp()

local slow_format_filetypes = {}

local function eval_parser(self, ctx)
  local ft = vim.bo[ctx.buf].filetype
  local ext = vim.fn.fnamemodify(ctx.filename, ":e")
  local options = self.options
  local parser = options
    and (
      (options.ft_parsers and options.ft_parsers[ft])
      or (options.ext_parsers and options.ext_parsers[ext])
    )
  if parser then
    return { "--parser", parser }
  end
end

local function prettier(tab_width)
  local function get_args(self, ctx)
    local args = eval_parser(self, ctx) or { "--stdin-filepath", "$FILENAME" }
    return vim.list_extend(
      args,
      { "--tab-width=" .. tab_width, "--prose-wrap", "always" }
    )
  end

  return {
    command = "prettier",
    args = function(self, ctx)
      return get_args(self, ctx)
    end,
    cwd = require("conform.formatters.prettierd").cwd,
  }
end

local odinfmt = function()
  return {
    command = "odinfmt",
    args = { "-stdin" },
  }
end

---@type PluginConfig
return {
  spec = {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
  },

  opts = function()
    return {
      formatters = {
        odinfmt = odinfmt(),
        prettier2 = prettier(2),
        prettier4 = prettier(4),
      },

      formatters_by_ft = languages.formatters_by_ft(),

      format_on_save = function(bufnr)
        if
          slow_format_filetypes[vim.bo[bufnr].filetype]
          or vim.g.disable_autoformat
        then
          return
        end
        local function on_format(err)
          if err and err:match("timeout$") then
            slow_format_filetypes[vim.bo[bufnr].filetype] = true
          end
        end

        local lsp_fallback = false
        for _, ft in ipairs(lsp_fts) do
          if ft == vim.bo[bufnr].filetype then
            lsp_fallback = true
            break
          end
        end

        return {
          timeout_ms = vim.g.formatter_timeout_ms,
          lsp_fallback = lsp_fallback,
        },
          on_format
      end,

      format_after_save = function(bufnr)
        if
          not slow_format_filetypes[vim.bo[bufnr].filetype]
          or vim.g.disable_autoformat
        then
          return
        end

        local lsp_fallback = false
        for _, ft in ipairs(lsp_fts) do
          if ft == vim.bo[bufnr].filetype then
            lsp_fallback = true
            break
          end
        end

        return { lsp_fallback = lsp_fallback }
      end,
    }
  end,

  mappings = function()
    return {
      Conform = {
        n = {
          {
            desc = "Format file",
            lhs = "<leader>fm",
            rhs = function()
              require("conform").format({ lsp_fallback = true })
            end,
          },
        },
      },
    }
  end,
}
