return {
  default_file_explorer = true,
  use_default_keymaps = true,
  view_options = {
    show_hidden = true,
    is_always_hidden = function(name, _)
      return name == ".."
    end,
    case_insensitive = true,
  },
  columns = {
    "size",
    "permissions",
    "icon",
  },
}
