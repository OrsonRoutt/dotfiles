local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

augroup("user", { clear = true })

-- Setup help file type.
autocmd({"BufRead", "BufNewFile"}, {
  group = "user",
  pattern = "*/doc/*.txt",
  callback = function() vim.bo.filetype = "help" end,
})

-- Setup vimwiki file type.
autocmd({"BufRead", "BufNewFile"}, {
  group = "user",
  pattern = "*.wiki",
  callback = function() vim.bo.filetype = "vimwiki" end,
})

-- Stop comments continuing on <CR> and o/O.
autocmd("FileType", {
  callback = function() vim.opt_local.formatoptions:remove({"r", "o"}) end,
})

-- Yank highlight.
autocmd("TextYankPost", {
  group = "user",
  callback = function() vim.hl.on_yank() end,
})

-- Close terminals on ok status.
autocmd("TermClose", {
  group = "user",
  callback = function(opts)
    if vim.v.event.status == 0 then
      local buf = opts.buf
      if vim.api.nvim_buf_is_loaded(buf) then
        vim.api.nvim_buf_delete(buf, { force = true })
      end
    end
  end,
})

-- Update statusline on LSP progress.
autocmd({"LspProgress", "ModeChanged"}, {
  group = "user",
  pattern = "*",
  command = "redrawstatus",
})

-- Notify fish of cwd change on suspend.
autocmd("VimSuspend", {
  group = "user",
  callback = function()
    local tmp = io.open("/tmp/fish_cwd", "w")
    if tmp then
      tmp:write(vim.fn.getcwd())
      tmp:close()
    end
  end,
})

require("scripts.whitespace").autocmds()
