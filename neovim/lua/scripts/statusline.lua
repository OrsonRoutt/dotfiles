local modes = {
  n = {"NORMAL", "Normal"},
  no = {"NORMAL o", "Normal"},
  nov = {"NORMAL ov", "Normal"},
  noV = {"NORMAL oV", "Normal"},
  ["no"] = {"NORMAL o^V", "Normal"},
  niI = {"NORMAL iT", "Normal"},
  niR = {"NORMAL RT", "Normal"},
  niV = {"NORMAL RvT", "Normal"},
  nt = {"NTERMINAL", "Normal"},
  ntT = {"NTERMINAL T", "Normal"},
  v = {"VISUAL", "Visual"},
  vs = {"VISUAL s", "Visual"},
  V = {"V-LINE", "Visual"},
  Vs = {"V-LINE s", "Visual"},
  [""] = {"V-BLOCK", "Visual"},
  ["s"] = {"V-BLOCK s", "Visual"},
  s = {"SELECT", "Select"},
  S = {"S-LINE", "Select"},
  [""] = {"S-BLOCK", "Select"},
  i = {"INSERT", "Insert"},
  ic = {"INSERT c", "Insert"},
  ix = {"INSERT x", "Insert"},
  R = {"REPLACE", "Replace"},
  Rc = {"REPLACE c", "Replace"},
  Rx = {"REPLACE x", "Replace"},
  Rv = {"V-REPLACE", "Replace"},
  Rvc = {"V-REPLACE c", "Replace"},
  Rvx = {"V-REPLACE x", "Replace"},
  c = {"COMMAND", "Command"},
  cr = {"COMMAND r", "Command"},
  cv = {"EX-MODE", "Command"},
  cvr = {"EX-MODE r", "Command"},
  r = {"PROMPT", "Confirm"},
  rm = {"MORE", "Confirm"},
  ["r?"] = {"CONFIRM", "Confirm"},
  ["!"] = {"SHELL", "Terminal"},
  t = {"TERMINAL", "Terminal"},
}

local function get_buf()
  return vim.api.nvim_win_get_buf(vim.g.statusline_winid or 0)
end

local function get_stl_mode()
  local mode = vim.api.nvim_get_mode().mode
  return "%#Stl_" .. modes[mode][2] .. "Mode#  " .. modes[mode][1] .. " "
end

local function get_stl_file()
  local file = ""
  if vim.bo.filetype == "qf" then
    local qf = vim.api.nvim_eval_statusline("%q", {})
    if qf.width ~= 0 then file = qf.str .. " " end
    if vim.w.quickfix_title then file = file .. vim.w.quickfix_title .. " " end
    if #file == 0 then file = "??? " end
  else
    local bufname = vim.fn.bufname()
    if #bufname == 0 then file = "[No Name] "
    else
      bufname = vim.fn.fnamemodify(bufname, ":~:.")
      if vim.o.columns > 100 and #bufname <= 50 then
        file = bufname
      else
        file = vim.fn.fnamemodify(bufname, ":t")
        if #file == 0 then file = vim.fn.fnamemodify(bufname, ":h:t") .. require("scripts.utils").pathsep end
      end
      file = file .. " "
    end
  end
  if #file > 51 then file = "..." .. file:sub(-48) end
  local vals = vim.api.nvim_eval_statusline("%m%r%h%w", {})
  if vals.width ~= 0 then
    return "%#Stl_Highlight# " .. file .. vals.str .. " %#StatusLine#"
  end
  return "%#Stl_Highlight# " .. file .. "%#StatusLine#"
end

local function get_stl_pos()
  local cwd = vim.fn.fnamemodify(vim.fn.getcwd(), ":~:t")
  if cwd == "" or cwd == "." then return "%#Stl_Highlight# %l/%L, %c " end
  if #cwd > 50 then cwd = "..." .. cwd:sub(-47) end
  return "%#Stl_Highlight#  " .. cwd .. " | %l/%L, %c "
end

local function get_stl_after_file()
  local buf = vim.b[get_buf()]
  if not buf.gitsigns_status or vim.o.columns <= 100 then return "" end
  local git_data = buf.gitsigns_status_dict
  local git = " 󰘬 " .. git_data.head
  if vim.o.columns > 150 then
    if git_data.added and git_data.added ~= 0 then git = git .. " %#GitsignsAdd# " .. git_data.added end
    if git_data.changed and git_data.changed ~= 0 then git = git .. " %#GitsignsChange# " .. git_data.changed end
    if git_data.removed and git_data.removed ~= 0 then git = git .. " %#GitsignsDelete# " .. git_data.removed end
  end
  return git .. "%#StatusLine#"
end

local function get_stl_before_pos()
  local buf = get_buf()
  local res = ""
  local encoding = vim.opt.fileencoding:get()
  if #encoding ~= 0 then res = string.upper(encoding) .. ", " end
  res = res .. vim.opt.tabstop:get() .. (vim.opt.expandtab:get() and "S" or "T") .. " "
  local lsp = ""
  if vim.lsp and vim.o.columns > 100 then
    if vim.o.columns > 150 then
      local err = #vim.diagnostic.get(buf, { severity = vim.diagnostic.severity.ERROR })
      local warn = #vim.diagnostic.get(buf, { severity = vim.diagnostic.severity.WARN })
      local hint = #vim.diagnostic.get(buf, { severity = vim.diagnostic.severity.HINT })
      local info = #vim.diagnostic.get(buf, { severity = vim.diagnostic.severity.INFO })
      if err and err ~= 0 then lsp = lsp .. "%#DiagnosticError#󰅙 " .. err .. " " end
      if warn and warn ~= 0 then lsp = lsp .. "%#DiagnosticWarn# " .. warn .. " " end
      if hint and hint ~= 0 then lsp = lsp .. "%#DiagnosticHint#󰌵 " .. hint .. " " end
      if info and info ~= 0 then lsp = lsp .. "%#DiagnosticInfo# " .. info .. " " end
    end
    for _, client in ipairs(vim.lsp.get_clients()) do
      if client.attached_buffers[buf] then
        lsp = lsp .. "%#@function#  " .. client.name
        break
      end
    end
    if #lsp ~= 0 then
      if #res ~= 0 then res = "| " .. res end
      res = lsp .. "%#StatusLine# " .. res
    end
  end
  if vim.g.grapple and vim.o.columns > 180 then
    local grapple = require("grapple").statusline()
    if #grapple ~= 0 then
      if #res ~= 0 then res = "| " .. res end
      res = "%#@keyword#" .. grapple .. "%#StatusLine# " .. res
    end
  end
  return res
end

_G.get_statusline = function()
  return string.format(
    "%s%s%%<%s%%=%s%s",
    get_stl_mode(),
    get_stl_file(),
    get_stl_after_file(),
    get_stl_before_pos(),
    get_stl_pos()
  )
end
