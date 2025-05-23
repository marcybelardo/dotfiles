vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.g.root_spec = { "lsp", { ".git", "lua" }, "cwd" }

local opt = vim.opt

opt.confirm = true
opt.cursorline = true
opt.expandtab = true
opt.ignorecase = true
opt.list = true
opt.mouse = "a"
opt.number = true
opt.relativenumber = true
opt.ruler = false
opt.scrolloff = 4
opt.shiftround = true
opt.shiftwidth = 4
opt.showmode = true
opt.sidescrolloff = 8
opt.signcolumn = "yes"
opt.smartcase = true
opt.smartindent = true
opt.spelllang = { "en" }
opt.splitbelow = true
opt.splitkeep = "screen"
opt.splitright = true
opt.tabstop = 4
opt.termguicolors = true
opt.timeoutlen = vim.g.vscode and 1000 or 300
opt.updatetime = 200
opt.virtualedit = "block"
opt.wildmode = "longest:full,full"
opt.winminwidth = 5
opt.wrap = false

vim.g.markdown_recommended_style = 0

