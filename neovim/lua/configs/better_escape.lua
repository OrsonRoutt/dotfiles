return {
  timeout = vim.o.timeoutlen,
  default_mappings = false,
  mappings = {
    t = {
      ["<Esc>"] = {
        ["<Esc>"] = "<C-\\><C-n>",
      },
    },
  },
}
