_G.get_tabline = function()
  local str = ""
  local tab = vim.fn.tabpagenr()
  if tab ~= 1 then str = str .. "%#TabLine#" end
  local tabids = vim.api.nvim_list_tabpages()
  for i=1,#tabids do
    str = str .. "%" .. i .. "T"
    if i == tab then str = str .. "%#TabLineSelInd#▏%#TabLineSel#"
    elseif i == tab + 1 then str = str .. "%#TabLine#▏"
    else str = str .. "▏" end
    local s, sess = pcall(vim.api.nvim_tabpage_get_var, tabids[i], "session")
    if s then str = str .. "[" .. sess .. "] "
    else str = str .. vim.fn.fnamemodify(vim.fn.getcwd(0, i), ":~:t") .. " " end
    str = str .. "%T"
  end
  str = str .. "%#TabLineFill#%<"
  return str
end
