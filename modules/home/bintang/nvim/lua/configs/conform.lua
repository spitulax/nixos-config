local slow_format_filetypes = {}

local deno_fmt = function()
  local extensions = {
    javascript = "js",
    json = "json",
    jsonc = "jsonc",
    markdown = "md",
    typescript = "ts",
  }

  return {
    command = "deno",
    args = function(_, ctx)
      return {
        "fmt",
        "-",
        "--line-width",
        "100",
        "--no-semicolons",
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
  opts = {
    formatters = {
      deno_fmt = deno_fmt(),
      odinfmt = odinfmt(),
    },

    formatters_by_ft = {
      go = { "gofmt" },
      rust = { "rustfmt" },
      nix = { "nixpkgs_fmt" },
      gdscript = { "gdformat" },
      c = { "clang-format" },
      cpp = { "clang-format" },
      odin = { "odinfmt" },
      javascript = { "deno_fmt" },
      typescript = { "deno_fmt" },
      json = { "deno_fmt" },
      jsonc = { "deno_fmt" },
      markdown = { "deno_fmt" },
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
  },

  mappings = {
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
  },
}
