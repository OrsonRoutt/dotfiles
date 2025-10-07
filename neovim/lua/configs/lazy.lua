return {
  defaults = { lazy = true },

  spec = { import = "plugins" },

  ui = {
    icons = {
      ft = "",
      lazy = "󰂠 ",
      loaded = "",
      not_loaded = "",
    },
  },

  performance = {
    rtp = {
      disabled_plugins = {
        "tohtml",
        "gzip",
        "matchit",
        "netrwPlugin",
        "tarPlugin",
        "spellfile",
        "zipPlugin",
        "tutor",
        "rplugin",
      },
    },
  },
}
