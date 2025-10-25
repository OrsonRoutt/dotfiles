local telescope = require("telescope")

telescope.load_extension("fzf")
telescope.load_extension("vw")
telescope.load_extension("terms")
telescope.load_extension("projects")

return {
  defaults = {
    prompt_prefix = "   ",
    borderchars = { "", "", "", "", "", "", "", "" },
    sorting_strategy = "ascending",
    layout_strategy = "flex",
    layout_config = {
      horizontal = {
        prompt_position = "top",
        preview_width = 0.55,
      },
      vertical = {
        prompt_position = "top",
        preview_height = 0.50,
      },
      width = { padding = 0 },
      height = { padding = 0 },
    },
    mappings = {
      n = { ["q"] = require("telescope.actions").close },
    },
  },
  extensions = {
    fzf = {
      fuzzy = true,
      override_generic_sorter = true,
      override_file_sorter = true,
      case_mode = "smart_case",
    },
  },
}
