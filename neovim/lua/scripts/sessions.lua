local M = {}

M.init = function()
  vim.fn.mkdir(vim.g.sessions_dir, "p")
end

M.save_session = function(name)
  vim.cmd("mks! " .. vim.g.sessions_dir .. name .. ".vim")
end

M.load_session = function(name)
  local path = vim.g.sessions_dir .. name .. ".vim"
  if vim.fn.filereadable(path) ~= 0 then
    vim.cmd("so " .. path)
    return true
  else
    return false
  end
end

M.del_session = function(name)
  return os.remove(vim.g.sessions_dir .. name .. ".vim")
end

M.get_sessions = function()
  return vim.fn.split(vim.fn.glob(vim.g.sessions_dir .. "*.vim"), "\n")
end

return M
