return {
  select = {
    enable = true,
    lookahead = true,
    keymaps = {
      ["af"] = { query = "@function.outer", desc = "function block" },
      ["if"] = { query = "@function.inner", desc = "inner function" },
      ["ac"] = { query = "@class.outer", desc = "class block" },
      ["ic"] = { query = "@class.inner", desc = "inner class" },
      ["an"] = { query = "@comment.outer", desc = "comment" },
    },
  },
  move = {
    enable = true,
    set_jumps = true,
    goto_next_start = {
      ["]m"] = { query = "@function.outer", desc = "next function start" },
      ["]]"] = { query = "@class.outer", desc = "next class start" },
      ["]n"] = { query = "@comment.outer", desc = "next comment start" },
    },
    goto_next_end = {
      ["]M"] = { query = "@function.outer", desc = "next function end" },
      ["]["] = { query = "@class.outer", desc = "next class end" },
      ["]N"] = { query = "@comment.outer", desc = "next comment end" },
    },
    goto_previous_start = {
      ["[m"] = { query = "@function.outer", desc = "previous function start" },
      ["[["] = { query = "@class.outer", desc = "previous class start" },
      ["[n"] = { query = "@comment.outer", desc = "previous comment start" },
    },
    goto_previous_end = {
      ["[M"] = { query = "@function.outer", desc = "previous function end" },
      ["[]"] = { query = "@class.outer", desc = "previous class end" },
      ["[N"] = { query = "@comment.outer", desc = "previous comment end" },
    },
  },
  swap = {
    enable = true,
    swap_next = {
      ["<leader>a"] = { query = "@parameter.inner", desc = "swap next parameter" },
    },
    swap_previous = {
      ["<leader>A"] = { query = "@parameter.inner", desc = "swap previous parameter" },
    },
  },
}
