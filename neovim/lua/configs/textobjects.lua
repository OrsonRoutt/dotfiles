local M = {}

M.setup = function()
  -- Config.
  require("nvim-treesitter-textobjects").setup({
    select = {
      lookahead = true,
    },
    move = {
      set_jumps = true,
    },
  })
  -- Select mappings.
  vim.keymap.set({"x", "o"}, "am", function()
    require("nvim-treesitter-textobjects.select").select_textobject("@function.outer", "textobjects")
  end, { desc = "function block" })
  vim.keymap.set({"x", "o"}, "im", function()
    require("nvim-treesitter-textobjects.select").select_textobject("@function.inner", "textobjects")
  end, { desc = "inner function" })
  vim.keymap.set({"x", "o"}, "ac", function()
    require("nvim-treesitter-textobjects.select").select_textobject("@class.outer", "textobjects")
  end, { desc = "class block" })
  vim.keymap.set({"x", "o"}, "ic", function()
    require("nvim-treesitter-textobjects.select").select_textobject("@class.inner", "textobjects")
  end, { desc = "inner class" })
  vim.keymap.set({"x", "o"}, "an", function()
    require("nvim-treesitter-textobjects.select").select_textobject("@comment.outer", "textobjects")
  end, { desc = "comment block" })
  vim.keymap.set({"x", "o"}, "in", function()
    require("nvim-treesitter-textobjects.select").select_textobject("@comment.inner", "textobjects")
  end, { desc = "inner comment" })
  -- Move mappings.
  vim.keymap.set({"n", "x", "o"}, "]m", function()
    require("nvim-treesitter-textobjects.move").goto_next_start("@function.outer", "textobjects")
  end, { desc = "next function start" })
  vim.keymap.set({"n", "x", "o"}, "]M", function()
    require("nvim-treesitter-textobjects.move").goto_next_end("@function.outer", "textobjects")
  end, { desc = "next function end" })
  vim.keymap.set({"n", "x", "o"}, "[m", function()
    require("nvim-treesitter-textobjects.move").goto_previous_start("@function.outer", "textobjects")
  end, { desc = "previous function start" })
  vim.keymap.set({"n", "x", "o"}, "[M", function()
    require("nvim-treesitter-textobjects.move").goto_previous_end("@function.outer", "textobjects")
  end, { desc = "previous function end" })
  vim.keymap.set({"n", "x", "o"}, "]n", function()
    require("nvim-treesitter-textobjects.move").goto_next_start("@comment.outer", "textobjects")
  end, { desc = "next comment start" })
  vim.keymap.set({"n", "x", "o"}, "]N", function()
    require("nvim-treesitter-textobjects.move").goto_next_end("@comment.outer", "textobjects")
  end, { desc = "next comment end" })
  vim.keymap.set({"n", "x", "o"}, "[n", function()
    require("nvim-treesitter-textobjects.move").goto_previous_start("@comment.outer", "textobjects")
  end, { desc = "previous comment start" })
  vim.keymap.set({"n", "x", "o"}, "[N", function()
    require("nvim-treesitter-textobjects.move").goto_previous_end("@comment.outer", "textobjects")
  end, { desc = "previous comment end" })
  vim.keymap.set({"n", "x", "o"}, "]]", function()
    require("nvim-treesitter-textobjects.move").goto_next_start("@class.outer", "textobjects")
  end, { desc = "next class start" })
  vim.keymap.set({"n", "x", "o"}, "][", function()
    require("nvim-treesitter-textobjects.move").goto_next_end("@class.outer", "textobjects")
  end, { desc = "next class end" })
  vim.keymap.set({"n", "x", "o"}, "[[", function()
    require("nvim-treesitter-textobjects.move").goto_previous_start("@class.outer", "textobjects")
  end, { desc = "previous class start" })
  vim.keymap.set({"n", "x", "o"}, "[]", function()
    require("nvim-treesitter-textobjects.move").goto_previous_end("@class.outer", "textobjects")
  end, { desc = "previous class end" })
  -- Swap mappings.
  vim.keymap.set("n", "<leader>a", function()
    require("nvim-treesitter-textobjects.swap").swap_next("@parameter.inner")
  end, { desc = "swap next parameter" })
  vim.keymap.set("n", "<leader>A", function()
    require("nvim-treesitter-textobjects.swap").swap_previous("@parameter.inner")
  end, { desc = "swap previous parameter" })
end

return M
