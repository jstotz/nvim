-- Customize None-ls sources
--

---@type LazySpec
return {
  "nvimtools/none-ls.nvim",
  -- opts = function(_, opts)
  --   -- config variable is the default configuration table for the setup function call
  --   local null_ls = require "null-ls"
  --   opts.debug = true
  --
  --   -- Check supported formatters and linters
  --   -- https://github.com/nvimtools/none-ls.nvim/tree/main/lua/null-ls/builtins/formatting
  --   -- https://github.com/nvimtools/none-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
  --   opts.sources = {
  --     null_ls.builtins.formatting.prettierd.with {
  --       extra_filetypes = { "ruby" },
  --     },
  --   }
  --   return opts
  -- end,
}
