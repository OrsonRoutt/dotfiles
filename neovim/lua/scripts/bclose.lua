local M = {}

local get_buf_opt = vim.api.nvim_get_option_value

local bl_filetypes = { "lazy" }
local bl_buftypes = { "terminal", "quickfix", "prompt" }
local file_buftypes = { "", "help" }

local function filter_bl(bufs)
  return vim.tbl_filter(function(buf)
    local bufnr = buf.bufnr
    return not vim.tbl_contains(bl_filetypes, get_buf_opt("filetype", { buf = bufnr }))
      and not vim.tbl_contains(bl_buftypes, get_buf_opt("buftype", { buf = bufnr }))
  end, bufs)
end

local function filter_unsaved(bufs)
  return vim.tbl_filter(function(buf)
    return not get_buf_opt("modified", { buf = buf.bufnr })
  end, bufs)
end

local function filter_working(bufs)
  return vim.tbl_filter(function(buf)
    return #buf.windows <= 0
  end, bufs)
end

local function filter_terminal(bufs)
  return vim.tbl_filter(function(buf)
    return get_buf_opt("buftype", { buf = buf.bufnr }) == "terminal"
  end, bufs)
end

local function del(bufs)
  vim.tbl_map(function(buf)
	  vim.api.nvim_buf_delete(buf.bufnr, { force = true })
	end, bufs)
	vim.api.nvim_command("redrawt")
end

M.delete = function(del_unsaved)
  local bufs = filter_bl(vim.fn.getbufinfo({ buflisted = 1 }))
	if (not del_unsaved) then bufs = filter_unsaved(bufs) end
  del(bufs)
  vim.notify("deleted " .. #bufs .. " buffers")
end

M.isolate = function(del_unsaved)
  local bufs = filter_bl(vim.fn.getbufinfo({ buflisted = 1 }))
  if (not del_unsaved) then bufs = filter_unsaved(bufs) end
  local cur_buf = vim.api.nvim_get_current_buf()
  bufs = vim.tbl_filter(function(buf) return buf.bufnr ~= cur_buf end, bufs)
  del(bufs)
  vim.notify("deleted " .. #bufs .. " buffers")
end

M.cleanup = function()
  local bufs = filter_working(filter_unsaved(filter_bl(vim.fn.getbufinfo({ buflisted = 1 }))))
  del(bufs)
  vim.notify("cleaned " .. #bufs .. " buffers")
end

M.cleanup_term = function()
  local bufs = filter_working(filter_terminal(vim.fn.getbufinfo()))
  del(bufs)
  vim.notify("cleaned " .. #bufs .. " terminals")
end

M.delete_term = function()
  local bufs = filter_terminal(vim.fn.getbufinfo())
  del(bufs)
  vim.notify("deleted " .. #bufs .. " terminals")
end

M.cleanup_tab = function()
  -- Get CWD and tab number.
  local cwd = vim.fn.getcwd()
  local tab = vim.fn.tabpagenr()
  -- Get unique CWDs from other tabs.
  local cwds = {}
  local n = 1
  for i=1,vim.fn.tabpagenr("$") do
    if i ~= tab then
      local c = vim.fn.getcwd(-1, i)
      if c ~= cwd and not vim.tbl_contains(cwds, c) then
        cwds[n] = c
        n = n + 1
      end
    end
  end
  -- 'is unique to tab' filter.
  local bufs = vim.tbl_filter(function(buf)
    -- If open in a window, this decides its inclusion.
    if #buf.windows > 0 then
      -- If open in another tab, no, otherwise it's only in this one so yes.
      for _, v in ipairs(buf.windows) do
        if vim.api.nvim_tabpage_get_number(vim.api.nvim_win_get_tabpage(v)) ~= tab then
          return false
        end
      end
      return true
    else
      -- Check buftype.
      local buftype = get_buf_opt("buftype", { buf = buf.bufnr })
      -- If nofile and not modified, might as well remove it.
      if buftype == "nofile" and not get_buf_opt("modified", { buf = buf.bufnr }) then return true end
      -- If a file buftype, continue with checks.
      if vim.tbl_contains(file_buftypes, buftype) then
        -- If file name is prefixed by CWD and isn't by any other tab's CWD, yes.
        if buf.name:find(cwd, 1, true) == 1 then
          for _, c in ipairs(cwds) do
            if buf.name:find(c, 1, true) == 1 then return false end
          end
          return true
        end
      end
      return false
    end
  end, vim.fn.getbufinfo())
  -- Delete all non-modified buffers, return all modified ones.
  local modified = {}
  n = 1
  for _, v in ipairs(bufs) do
    if get_buf_opt("modified", { buf = v.bufnr }) then
      modified[n] = v
      n = n + 1
    else vim.api.nvim_buf_delete(v.bufnr, { force = true }) end
  end
  return modified
end

return M
