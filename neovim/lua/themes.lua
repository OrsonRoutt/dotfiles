vim.g.theme_file = vim.fn.stdpath("data") .. "/theme.lua"
vim.g.themes = { "horizon" }

require("scripts.themes").load_theme_file()
