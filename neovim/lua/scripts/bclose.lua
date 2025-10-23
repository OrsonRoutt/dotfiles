local M = {}

local get_buf_opt = vim.api.nvim_get_option_value

local bl_filetypes = { "lazy" }
local bl_buftypes = { "terminal", "quickfix", "prompt" }

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

return M
