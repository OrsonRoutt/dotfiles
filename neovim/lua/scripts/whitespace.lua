local M = {}

_G.matches = {}

local ignore_buf = {"nofile", "terminal", "quickfix"}
local ignore_file = {"TelescopePrompt"}

local function try_highlight()
  local win = vim.api.nvim_get_current_win()
  local id = matches[win]
  if vim.tbl_contains(ignore_buf, vim.bo.buftype) or vim.tbl_contains(ignore_file, vim.bo.filetype) then
    if id ~= nil then
      vim.fn.matchdelete(id)
      matches[win] = nil
    end
  elseif id == nil then
    matches[win] = vim.fn.matchadd("DiffDelete", [[\s\+$]], -1)
  end
end

M.trim = function()
  local pos = vim.api.nvim_win_get_cursor(0)
  vim.cmd([[keepp %s/\s\+$//e]])
  vim.api.nvim_win_set_cursor(0, pos)
end

M.autocmds = function()
  vim.api.nvim_create_autocmd("FileType", { group = "user", callback = try_highlight })
  vim.api.nvim_create_autocmd("BufEnter", { group = "user", callback = try_highlight })
  vim.api.nvim_create_autocmd("UiEnter", { group = "user", callback = try_highlight })
end

return M
