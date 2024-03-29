local toggle_term_cmd = require("astronvim.utils").toggle_term_cmd
local utils = require("user.utils")

return {
  n = {
    ["<leader>gH"] = {
      function() toggle_term_cmd("lazygit log --filter " .. ("%q"):format(utils.git_root_relative_path_current_file())) end,
      desc = "File history",
    },
    ["<leader>gl"] = { "<cmd>Git blame<cr>", desc = "View Git blame" },
    ["<leader>gg"] = false, -- disable default lazygit mapping to remap to neogit
  },
}
