local o = vim.o
local g = vim.g

o.laststatus = 3
o.showmode = false

o.clipboard = "unnamedplus"

o.guicursor = "n-v-c-sm:block-Cursor/lCursor,i-ci-ve:ver25-Cursor/lCursor,r-cr-o:hor20-Cursor/lCursor,t:block-TermCursor,a:blinkon0"

o.cursorline = true
o.cursorlineopt = "number,screenline"

o.foldenable = true
o.foldlevelstart = 99

o.expandtab = true
o.shiftwidth = 2
o.smartindent = true
o.tabstop = 2
o.softtabstop = 2
o.backspace = "indent,eol,start"

o.scrolloff = 10
o.sidescrolloff = 20

o.selectmode = "mouse,key"
o.keymodel = "startsel,stopsel"

o.ignorecase = true
o.smartcase = true

o.mouse = ""
o.mousescroll = "ver:0,hor:0"

o.number = true
o.relativenumber = true
o.numberwidth = 2

o.shortmess = "aoOtTIF"

o.signcolumn = "yes:1"

o.splitkeep = "screen"
o.splitbelow = true
o.splitright = true

o.timeoutlen = 300

o.backup = false
o.writebackup = true
o.swapfile = true
o.undofile = true

o.updatetime = 250

o.history = 1000

o.inccommand = "split"

o.sessionoptions = "buffers,curdir,folds,help,winsize"

require("scripts.statuscol")
vim.o.statuscolumn = "%!v:lua.get_statuscol()"
require("scripts.statusline")
vim.o.statusline = "%!v:lua.get_statusline()"

vim.diagnostic.config({
  signs = false,
  virtual_text = true,
})

g.projects_file = vim.fn.stdpath("data") .. "/projects.lua"
g.sessions_dir = vim.fn.stdpath("state") .. "/sessions/"
require("scripts.sessions").init()

g.qf_disable_statusline = 1

g.loaded_node_provider = 0
g.loaded_python3_provider = 0
g.loaded_perl_provider = 0
g.loaded_ruby_provider = 0

local u = require("scripts.utils")
vim.env.PATH = vim.fn.stdpath("data") .. u.pathsep .. "mason" .. u.pathsep .. "bin" .. u.pdelim .. vim.env.PATH
