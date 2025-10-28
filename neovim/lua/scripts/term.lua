local M = {}

_G.terms = {}

local function tabline_height()
  local opt = vim.o.showtabline
  if opt == 0 then return 0
  elseif opt == 2 then return 1
  elseif vim.fn.tabpagenr("$") > 1 then return 1
  else return 0 end
end

local function bottom_height()
  local h = vim.o.cmdheight
  local sopt = vim.o.laststatus
  if sopt == 0 then return h
  elseif sopt == 1 then
    local wins = vim.api.nvim_tabpage_list_wins(0)
    local count = 0
    for _, win in ipairs(wins) do
      if vim.api.nvim_win_get_config(win).relative == "" then count = count + 1 end
    end
    return count > 1 and h + 1 or h
  else return h + 1 end
end

local function create_float(buf, opts)
  local theight = tabline_height()
  local vwidth = vim.o.columns
  local vheight = vim.o.lines - theight - bottom_height()
  local width = math.ceil(opts.width * vwidth)
  if width % 2 ~= vwidth % 2 then width = width - 1 end
  local height = math.ceil(opts.height * vheight)
  if height % 2 ~= vheight % 2 then height = height - 1 end
  local win_opts = {
    relative = "editor",
    width = width,
    height = height,
    row = theight + (vheight - height) / 2 - 1,
    col = (vwidth - width) / 2 - 1,
    style = "minimal",
    border = "rounded",
  }
  vim.api.nvim_open_win(buf, true, win_opts)
end

local function create_split(buf, opts)
  local win = opts.topl ~= nil and -1 or 0
  local win_opts = {
    win = win,
    split = opts.split,
  }
  if opts.height ~= nil then
    if win == -1 then
      local height = vim.o.lines - tabline_height() - bottom_height()
      win_opts.height = math.ceil(opts.height * height)
    else
      win_opts.height = math.ceil(opts.height * vim.api.nvim_win_get_height(win))
    end
  end
  if opts.width ~= nil then
    if win == -1 then
      win_opts.width = math.ceil(opts.width * vim.o.columns)
    else
      win_opts.width = math.ceil(opts.width * vim.api.nvim_win_get_width(win))
    end
  end
  vim.api.nvim_open_win(buf, true, win_opts)
end

M.new_split = function(opts)
  local buf = vim.api.nvim_create_buf(false, true)
  create_split(buf, opts)
  vim.cmd("star")
  vim.fn.jobstart(vim.o.shell, { term = true })
  vim.cmd("setl winhl=NormalFloat:Normal,FloatBorder:Normal")
end

M.tggl_split = function(opts)
  local buf = terms[opts.id]
  if buf == nil or not vim.api.nvim_buf_is_valid(buf) then
    buf = vim.api.nvim_create_buf(false, true)
    terms[opts.id] = buf
  end
  local win = vim.fn.bufwinid(buf)
  if win == -1 then
    create_split(buf, opts)
    vim.cmd("star")
  else
    vim.api.nvim_win_close(win, true)
  end
  if vim.bo[buf].buftype ~= "terminal" then
    vim.fn.jobstart(vim.o.shell, { term = true })
    if opts.toggle ~= nil then
      for _, v in ipairs(opts.toggle) do
        vim.keymap.set("t", v, function() M.tggl_split(opts) end, { buffer = buf })
      end
    end
    vim.keymap.set("t", "<C-c>", function() M.tggl_split(opts) end, { buffer = buf })
    vim.cmd("setl winhl=NormalFloat:Normal,FloatBorder:Normal")
  end
end

M.tggl_float = function(opts)
  local buf = terms[opts.id]
  if buf == nil or not vim.api.nvim_buf_is_valid(buf) then
    buf = vim.api.nvim_create_buf(false, true)
    terms[opts.id] = buf
  end
  local win = vim.fn.bufwinid(buf)
  if win == -1 then
    create_float(buf, opts)
    vim.cmd("star")
  else
    vim.api.nvim_win_close(win, true)
  end
  if vim.bo[buf].buftype ~= "terminal" then
    vim.fn.jobstart(vim.o.shell, { term = true })
    if opts.toggle ~= nil then
      vim.keymap.set("t", opts.toggle, function() M.tggl_float(opts) end, { buffer = buf })
    end
    vim.keymap.set("t", "<C-c>", function() M.tggl_float(opts) end, { buffer = buf })
    vim.cmd("setl winhl=NormalFloat:Normal,FloatBorder:Normal")
  end
end

M.tggl_float_job = function(opts)
  local buf = terms[opts.id]
  if buf == nil or not vim.api.nvim_buf_is_valid(buf) then
    buf = vim.api.nvim_create_buf(false, true)
    terms[opts.id] = buf
  end
  local win = vim.fn.bufwinid(buf)
  if win == -1 then
    create_float(buf, opts)
    vim.cmd("star")
  else
    vim.api.nvim_win_close(win, true)
  end
  if vim.bo[buf].buftype ~= "terminal" then
    vim.fn.jobstart(opts.job, { term = true })
    vim.keymap.set("t", "<C-c>", function() M.tggl_float_job(opts) end, { buffer = buf })
    vim.cmd("setl winhl=NormalFloat:Normal,FloatBorder:Normal")
  end
end

M.new_float_job = function(opts)
  local buf = vim.api.nvim_create_buf(false, true)
  create_float(buf, opts)
  vim.cmd("star")
  vim.fn.jobstart(opts.job, { term = true })
  vim.cmd("setl winhl=NormalFloat:Normal,FloatBorder:Normal")
end

return M
