local M = {}

M.win = vim.fn.has("win32")

if M.win ~= 0 then
  M.pathsep = "\\"
  M.pdelim = ";"
else
  M.pathsep = "/"
  M.pdelim = ":"
end

return M
