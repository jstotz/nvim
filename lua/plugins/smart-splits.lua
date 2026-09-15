-- Override AstroNvim v4's version-1 pin for native Herdr support.
-- Keep this revision aligned with the dotfiles Herdr plugin installer.
return {
  "mrjones2014/smart-splits.nvim",
  version = false,
  commit = "ec76708f1617ef9e2ac353357fe52d2c997a0f06",
  event = "VeryLazy",
}
