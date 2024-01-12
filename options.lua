-- set vim options here (vim.<first_key>.<second_key> = value)
return {
  ---@type vim.opt
  o = {
    guifont = "FiraCode Nerd Font:h16",
    exrc = true,
    formatoptions = "cqj", -- disable hard wrapping by default
  },
  ---@type vim.opt
  g = {
    neovide_cursor_animation_length = 0,
    maplocalleader = ",",
  },
}
