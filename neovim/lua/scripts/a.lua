local M = {}

local ext_lookup = {
  c = {"h"},
  cpp = {"hpp","h","hh","hxx"},
  cc = {"h","hh","hpp"},
  cxx = {"h","hxx","hpp"},
  C = {"H","HH","h","hh"},
  CC = {"HH","H","h","hh"},
  h = {"c","cpp","cc","cxx","C","CC"},
  hpp = {"cpp","cc","cxx"},
  hh = {"cc","cpp","C","CC"},
  hxx = {"cxx","cpp"},
  H = {"C","CC"},
  HH = {"CC","C"},
}

M.get_header = function(path)
  local ext = vim.fn.fnamemodify(path, ":e")
  local lookup = ext_lookup[ext]
  if lookup == nil then
    vim.notify("file extension isn't in lookup table")
    return nil
  end
  local noext = vim.fn.fnamemodify(path, ":~:.:r") .. "."
  for _, v in ipairs(lookup) do
    local withext = noext .. v
    if vim.fn.filereadable(withext) == 1 then
      return withext
    end
  end
  return noext .. lookup[1]
end

return M
