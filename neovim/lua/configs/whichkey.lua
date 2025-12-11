require("which-key").add({
  { "<leader>b", group = "buffer" },
  { "<leader>d", group = "diagnostic" },
  { "<leader>f", group = "telescope" },
  { "<leader>g", group = "git/grapple" },
  { "<leader>o", group = "open" },
  { "<leader>s", group = "session" },
  { "<leader>t", group = "theme" },
  { "<leader>w", group = "vimwiki" },
})

return {
  triggers = {
    {"<leader>", mode = {"n"}},
    {"<localleader>", mode = {"n"}}
  },
}
