local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

augroup("user", { clear = true })

-- Setup 4 space tab filetypes.
autocmd("FileType", {
  group = "user",
  pattern = { "gdscript", "cpp" },
  callback = function()
    vim.bo.sw = 4
    vim.bo.sts = 4
    vim.bo.ts = 4
    vim.bo.expandtab = false
    vim.bo.softtabstop = 4
  end,
})

-- Setup spell check filetypes.
autocmd("FileType", {
  group = "user",
  pattern = { "markdown", "typst", "vimwiki" },
  callback = function() vim.opt_local.spell = true end,
})

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

-- Yank highlight.
autocmd("TextYankPost", {
  group = "user",
  callback = function() vim.highlight.on_yank() end,
})

-- Close terminals on ok status.
autocmd("TermClose", {
  group = "user",
  callback = function(opts)
    if vim.v.event.status == 0 then
      vim.api.nvim_buf_delete(opts.buf, { force = true })
    end
  end,
})

-- Update statusline on LSP progress.
autocmd("LspProgress", {
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

-- NVChad 'User FilePost' event.
autocmd({ "UIEnter", "BufReadPost", "BufNewFile" }, {
  group = vim.api.nvim_create_augroup("NvFilePost", { clear = true }),
  callback = function(args)
    local file = vim.api.nvim_buf_get_name(args.buf)
    local buftype = vim.api.nvim_get_option_value("buftype", { buf = args.buf })
    if not vim.g.ui_entered and args.event == "UIEnter" then
      vim.g.ui_entered = true
    end
    if file ~= "" and buftype ~= "nofile" and vim.g.ui_entered then
      vim.api.nvim_exec_autocmds("User", { pattern = "FilePost", modeline = false })
      vim.api.nvim_del_augroup_by_name("NvFilePost")
      vim.schedule(function()
        vim.api.nvim_exec_autocmds("FileType", {})
        if vim.g.editorconfig then require("editorconfig").config(args.buf) end
      end)
    end
  end,
})
