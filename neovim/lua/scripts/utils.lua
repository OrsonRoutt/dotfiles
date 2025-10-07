local M = {}

local win = vim.fn.has("win32")

if win ~= 0 then
  M.pathsep = "\\"
  M.pdelim = ";"
else
  M.pathsep = "/"
  M.pdelim = ":"
end

return M
