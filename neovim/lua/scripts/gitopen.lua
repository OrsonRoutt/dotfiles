local M = {}

M.gitopen = function(cwd)
  local out
  if cwd ~= nil then
    out = vim.fn.systemlist("git -C " .. cwd .. " remote get-url origin")
  else out = vim.fn.systemlist("git remote get-url origin") end
  if vim.v.shell_error ~= 0 then
    vim.notify("'git remote get-url origin' failed: " .. table.concat(out, "\n"), vim.log.levels.ERROR)
    return
  end
  vim.ui.open(out[1])
end

return M
