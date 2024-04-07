return {
  {
    "otavioschwanck/telescope-alternate",
    event = "BufRead",
    config = function()
      require("telescope").load_extension("telescope-alternate")
      require("telescope-alternate").setup({
        presets = { "rails", "rspec", "go" },
        open_only_one_with = "vertical_split",
      })
    end,
    keys = {
      { "<leader>fl", "<cmd>:Telescope telescope-alternate alternate_file<CR>", desc = "Find alternate files" },
    },
  },
}
