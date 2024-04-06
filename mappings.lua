return {
  n = {
    ["<leader>T"] = { name = "󰙨 Test" },
    ["<leader>gH"] = {
      "<cmd>:DiffviewFileHistory %<cr>",
      desc = "File history",
    },
    ["<leader>gl"] = { "<cmd>Git blame<cr>", desc = "View Git blame" },
    ["<leader>gg"] = false, -- disable default lazygit mapping to remap to neogit
  },
}
