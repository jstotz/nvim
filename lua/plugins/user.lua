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
    "stevearc/oil.nvim",
    opts = {},
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
      { "-", "<CMD>Oil<CR>", { desc = "Open parent directory" } },
    },
  },
  {
    "lewis6991/gitsigns.nvim",
    version = false,
    keys = {
      { "<leader>gB", "<CMD>Gitsigns blame<CR>", { desc = "Blame file" } },
    },
  },
  {
    "gbprod/substitute.nvim",
    opts = {},
    config = function(_plugin, opts)
      require("substitute").setup(opts)

      vim.keymap.set("n", "s", require("substitute").operator, { noremap = true })
      vim.keymap.set("n", "ss", require("substitute").line, { noremap = true })
      vim.keymap.set("n", "S", require("substitute").eol, { noremap = true })
      vim.keymap.set("x", "s", require("substitute").visual, { noremap = true })
    end,
  },
}
