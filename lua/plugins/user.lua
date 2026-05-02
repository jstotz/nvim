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
    "stevearc/oil.nvim",
    opts = {},
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
      { "-", "<CMD>Oil<CR>", desc = "Open parent directory" },
    },
  },
  {
    "lewis6991/gitsigns.nvim",
    version = false,
    keys = {
      { "<leader>gB", "<CMD>Gitsigns blame<CR>", desc = "Blame file" },
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
  {
    "ramilito/kubectl.nvim",
    config = function() require("kubectl").setup() end,
  },
  {
    "kawre/leetcode.nvim",
    build = ":TSUpdate html",
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
    },
    opts = {
      lang = "golang",
      injector = {
        ["golang"] = {
          before = "package main",
        },
      },
    },
  },
  {
    "retran/meow.yarn.nvim",
    dependencies = { "MunifTanjim/nui.nvim" },
    cmd = "MeowYarn",
    opts = {},
    keys = {
      {
        "<Leader>yt",
        function() require("meow.yarn").open_tree("type_hierarchy", "supertypes") end,
        desc = "Yarn: Type Hierarchy (Super)",
      },
      {
        "<Leader>yT",
        function() require("meow.yarn").open_tree("type_hierarchy", "subtypes") end,
        desc = "Yarn: Type Hierarchy (Sub)",
      },
      {
        "<Leader>yc",
        function() require("meow.yarn").open_tree("call_hierarchy", "callers") end,
        desc = "Yarn: Call Hierarchy (Callers)",
      },
      {
        "<Leader>yC",
        function() require("meow.yarn").open_tree("call_hierarchy", "callees") end,
        desc = "Yarn: Call Hierarchy (Callees)",
      },
    },
  },
  {
    "danielfalk/smart-open.nvim",
    branch = "0.2.x",
    config = function() require("telescope").load_extension("smart_open") end,
    dependencies = {
      "kkharji/sqlite.lua",
      { "nvim-telescope/telescope-fzy-native.nvim" },
    },
    keys = {
      { "<leader>ff", "<CMD>Telescope smart_open cwd_only=true<CR>", desc = "Find files" },
    },
  },
}
