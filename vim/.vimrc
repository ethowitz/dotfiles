call plug#begin('~/.local/share/nvim/plugged')

Plug 'atelierbram/Base4Tone-vim'
Plug 'airblade/vim-gitgutter'
Plug 'chrisbra/colorizer'
Plug 'junegunn/fzf'
Plug 'ap/vim-buftabline'
Plug 'scrooloose/nerdcommenter'
Plug 'tpope/vim-sleuth'
Plug 'Yggdroot/indentLine'
Plug 'francoiscabrol/ranger.vim'
Plug 'tpope/vim-fugitive'
Plug 'derekwyatt/vim-scala'
Plug 'cespare/vim-toml'
Plug 'rust-lang/rust.vim'
Plug 'neoclide/coc.nvim'
Plug 'dense-analysis/ale'
Plug 'neoclide/coc.nvim', {'branch': 'release'}

call plug#end()

filetype plugin indent on

set conceallevel=0

" persistent undo
set undofile
set undodir=$HOME/.cache/nvim/undo

" gitgutter
set updatetime=100

" themeing
set t_Co=256
set background=dark
set termguicolors
colorscheme Base4Tone_Classic_S_Dark
syntax on

set showtabline=2

au BufRead,BufNewFile *.sbt set filetype=scala

filetype plugin on
set nocompatible

" Status line
set laststatus=2

function! GitBranch()
  return system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
endfunction

function! StatuslineGit()
  return strlen(g:git_branch) > 0?'  '.g:git_branch.' ':''
endfunction

let g:git_branch = ""
autocmd BufEnter,BufLeave,BufDelete * let g:git_branch = GitBranch()

set statusline=
set statusline+=%#PmenuSel#
set statusline+=%{StatuslineGit()}
set statusline+=%#LineNr#
set statusline+=\ %f
set statusline+=\ 
set statusline+=%#LineNr#
set statusline+=%m
set statusline+=%=
"set statusline+=%#CursorColumn#
set statusline+=%#PmenuSel#
set statusline+=\ %y
set statusline+=\ %{&fileencoding?&fileencoding:&encoding}
set statusline+=\ \[%{&fileformat}\]
set statusline+=\ %l:%c
set statusline+=\ 

let g:indentLine_enabled = 1
let g:indentLine_char = "|"

" miscellaneous
set number
set expandtab
set matchtime=3
set colorcolumn=100
set tw=100

" reset cursor on exit
au VimLeave * set guicursor=a:ver100-blinkon0

" don't wrap lines
set nowrap
  autocmd FileType markdown setlocal wrap

" linting & code completion

let g:ale_linters = {'rust': ['analyzer']}

" keystrokes
let mapleader = "\<Space>"
nnoremap <Leader>b :ls<CR>:b<Space>
nnoremap <Leader>c :let @+ = expand("%")<CR>
nnoremap <Leader>p :FZF<CR>
nnoremap <Leader>w :bd<CR>
nnoremap <Leader>x :w<bar>bd<CR>
nnoremap <Leader>[ :bprev!<CR>
nnoremap <Leader>] :bnext!<CR>
nnoremap <Leader><CR> :noh<CR>

au VimEnter * :wincmd l

" share clipboard with system
set clipboard+=unnamedplus

" set background color to match terminal's
hi Normal guibg=NONE ctermbg=NONE
