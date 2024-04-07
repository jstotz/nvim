local header = {
  "      .-.             -.      ",
  "    .-+++-            =+-.    ",
  "  .-++++++=           =+++-.  ",
  " ..=+++++++=.         =+++++-.",
  "--- -++++++++:        =++++++=",
  "----.:++++++++-       =++++++=",
  "-----:.=+++++++=.     =++++++=",
  "-------.-++++++++:    =+++++++",
  "-------- :++++++++-   =+++++++",
  "--------  .=+++++++=. =+++++++",
  "--------    =++++++++::+++++++",
  "--------     -++++++++-.=+++++",
  "--------      .=+++++++=.-++++",
  "--------        =++++++++::+++",
  ":-------         -++++++++-.=-",
  "  :-----          .=+++++++:  ",
  "    :---            =++++-    ",
  "      :-             -+-      ",
}

---@type LazySpec
return {
  {
    "goolord/alpha-nvim",
    opts = function(_, opts) -- override the options using lazy.nvim
      opts.section.header.val = header
    end,
    config = function(_, opts)
      -- Skip AstroNvim default footer
      require("alpha").setup(opts.config)
    end,
  },

  {
    "L3MON4D3/LuaSnip",
    config = function(plugin, opts)
      -- include the default astronvim config that calls the setup call
      require "astronvim.plugins.configs.luasnip"(plugin, opts)
      -- load snippets paths
      require("luasnip.loaders.from_vscode").lazy_load {
        paths = { vim.fn.stdpath "config" .. "/snippets" },
      }
    end,
  },

  {
    "numToStr/Navigator.nvim",
    config = function()
      require("Navigator").setup {}
      vim.keymap.set({ "n", "t" }, "<C-h>", "<CMD>NavigatorLeft<CR>")
      vim.keymap.set({ "n", "t" }, "<C-l>", "<CMD>NavigatorRight<CR>")
      vim.keymap.set({ "n", "t" }, "<C-k>", "<CMD>NavigatorUp<CR>")
      vim.keymap.set({ "n", "t" }, "<C-j>", "<CMD>NavigatorDown<CR>")
      vim.keymap.set({ "n", "t" }, "<C-p>", "<CMD>NavigatorPrevious<CR>")
    end,
  },

  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        lua = { "stylua" },
        python = { "isort", "black" },
        javascript = { "prettierd" },
        ruby = { "prettierd" },
      },
    },
    format_on_save = {
      timeout_ms = 10000,
      lsp_fallback = true,
    },
  },
}
