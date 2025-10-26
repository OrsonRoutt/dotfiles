return {
  signs = {
    add = { text = "┃", show_count = true },
    change = { text = "┃", show_count = true },
    delete = { text = "▁", show_count = true },
    topdelete = { text = "▔", show_count = true },
    changedelete = { text = "~", show_count = true },
    untracked = { text = "┆", show_count = true },
  },
  signs_staged = {
    add = { text = "┃", show_count = true },
    change = { text = "┃", show_count = true },
    delete = { text = "▁", show_count = true },
    topdelete = { text = "▔", show_count = true },
    changedelete = { text = "~", show_count = true },
    untracked = { text = "┆", show_count = true },
  },
  count_chars = { "₁", "₂", "₃", "₄", "₅", "₆", "₇", "₈", "₉", ["+"] = "₊" },
  current_line_blame_opts = {
    delay = 0,
  },
}
