-- Set globals to be used in our config files
vim.g.start_directory = vim.fn.getcwd()

vim.g.mapleader = "\\"
vim.g.maplocalleader = " "

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)
require("lazy").setup({
  -- Disables the annoying pop-up every time I change something in my config
  change_detection = {
    enabled = false,
  },
  defaults = {
    lazy = false,
  },
  spec = {
    import = "plugins",
  },
})

-- Insert mode completion
vim.opt.shortmess = vim.opt.shortmess + { c = true }
vim.api.nvim_set_option("updatetime", 300)

-- Searching
vim.opt.ignorecase = true -- Ignore case in searches
vim.opt.smartcase = true -- Override ignorecase if search pattern contains a capital letter

-- grep
vim.opt.grepprg = "rg --vimgrep"
vim.opt.grepformat = "%f:%l:%c:%m"
vim.cmd("command! -nargs=+ Rg execute 'silent grep! <args>' | copen")

-- Quickfix
vim.cmd("packadd cfilter")

-- Layout and UI
vim.cmd.colorscheme("monokai-pro")

vim.g.vim_json_conceal = 0 -- Always show quotes in JSON files
vim.opt.cmdheight = 0 -- Don't waste a line for the command prompt below the status bar
vim.opt.cursorline = true -- Highlight the text line of the cursor
vim.opt.number = true -- Make line numbers default
vim.opt.relativenumber = true
vim.opt.scrolloff = 7
vim.opt.signcolumn = "yes" -- Always show sign column
vim.opt.splitbelow = true -- Always split below instead of above
vim.wo.wrap = false
vim.opt.winbar = " %{%v:lua.require'nvim-navic'.get_location()%}"

-- Tabs 'n spaces
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4

vim.opt.clipboard = "unnamedplus" -- Access system clipboard
-- vim.opt.jumpoptions = { "stack", "view" }
vim.opt.mouse = "a" -- Enable mouse mode
vim.opt.undodir = os.getenv("HOME") .. "/.local/share/nvim/undo" -- Directory where the undo files will be stored
vim.opt.undofile = true -- Save undo history

-- Toggle between absolute and hybrid line numbers
vim.cmd([[
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != "i" | set rnu   | endif
  autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu                  | set nornu | endif
augroup END
]])

-- Reload open files when they change on disk
vim.opt.autoread = true
vim.cmd([[autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * if mode() != 'c' | checktime | endif ]])
vim.cmd([[autocmd FileChangedShellPost *
        \ echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None ]])

vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
