local M = {}

M.setup = function()
  local parsers = {
    "vim", "lua", "vimdoc",
    "html", "css", "gdscript",
    "godot_resource", "gdshader",
    "cpp", "c", "markdown",
    "markdown_inline", "luadoc",
    "printf", "sql", "php",
    "typst", "comment", "python",
    "fish", "bash",
  }
  require("nvim-treesitter").install(parsers)
  local ft = {}
  local n = 1
  for _, v in ipairs(parsers) do
    for _, f in ipairs(vim.treesitter.language.get_filetypes(v)) do
      ft[n] = f
      n = n + 1
    end
  end
  vim.api.nvim_create_autocmd("FileType", {
    pattern = ft,
    callback = function()
      vim.treesitter.start()
      vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end,
  })
end

return M
