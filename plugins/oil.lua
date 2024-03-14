return {
  "stevearc/oil.nvim",
  opts = {},
  dependencies = { "nvim-tree/nvim-web-devicons" },
  keys = {
    { "<leader>fO", function() require("oil").open() end, desc = "Open folder in Oil" },
  },
}
