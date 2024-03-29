local utils = require("astronvim.utils")
local prefix = "<leader>g"
local icon = vim.g.icons_enabled and "󰰔 " or ""
utils.set_mappings({ n = { [prefix] = { desc = icon .. "Neogit" } } })

local fold_signs = { utils.get_icon("FoldClosed"), utils.get_icon("FoldOpened") }
return {
  {
    "NeogitOrg/neogit",
    dependencies = {
      {
        "nvim-lua/plenary.nvim",
        "sindrets/diffview.nvim",
      },
    },
    event = "User AstroGitFile",
    opts = function(_, opts)
      local disable_builtin_notifications = utils.is_available("nvim-notify") or utils.is_available("noice.nvim")

      return utils.extend_tbl(opts, {
        disable_builtin_notifications = disable_builtin_notifications,
        telescope_sorter = function()
          if utils.is_available("telescope-fzf-native.nvim") then
            return require("telescope").extensions.fzf.native_fzf_sorter()
          end
        end,
        integrations = { telescope = utils.is_available("telescope.nvim") },
        signs = { section = fold_signs, item = fold_signs },
      })
    end,
    keys = {
      { prefix .. "g", "<cmd>Neogit<CR>", desc = "Open Neogit" },
    },
  },
  {
    "catppuccin/nvim",
    optional = true,
    ---@type CatppuccinOptions
    opts = { integrations = { neogit = true } },
  },
}
