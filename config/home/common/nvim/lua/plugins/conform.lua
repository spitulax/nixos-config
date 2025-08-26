--- Auto-formatter.

local languages = require("internals.languages")

local lsp_fts = languages.fts_format_with_lsp()

local slow_format_filetypes = {}

local deno_fmt = function()
  local extensions = {
    javascript = "js",
    javascriptreact = "jsx",
    json = "json",
    jsonc = "jsonc",
    markdown = "md",
    typescript = "ts",
    typescriptreact = "tsx",
    html = "html",
    css = "css",
    yaml = "yaml",
  }

  return {
    command = "deno",
    args = function(_, ctx)
      return {
        "fmt",
        "-",
        "--line-width",
        "100",
        "--ext",
        extensions[vim.bo[ctx.buf].filetype],
      }
    end,
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
        deno_fmt = deno_fmt(),
        odinfmt = odinfmt(),
      },

      formatters_by_ft = languages.formatters_by_ft(),

      format_on_save = function(bufnr)
        if slow_format_filetypes[vim.bo[bufnr].filetype] or vim.g.disable_autoformat then
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

        return { timeout_ms = 200, lsp_fallback = lsp_fallback }, on_format
      end,

      format_after_save = function(bufnr)
        if not slow_format_filetypes[vim.bo[bufnr].filetype] or vim.g.disable_autoformat then
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
