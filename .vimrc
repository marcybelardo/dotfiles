set termguicolors
set encoding=utf8
set history=500

call plug#begin()

Plug 'tpope/vim-sensible'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-vinegar'
Plug 'junegunn/fzf.vim'
Plug 'junegunn/goyo.vim'
Plug 'lunacookies/vim-substrata'
Plug 'itchyny/lightline.vim'
Plug 'airblade/vim-gitgutter'

call plug#end()

packadd lsp

filetype plugin on
filetype indent on

set autoread
au FocusGained,BufEnter * silent! checktime

let mapleader="\<Space>"

nmap <leader>w :w!<CR>
nmap <leader>u :update<CR> :source<CR>
command! W execute 'w !sudo tee % > /dev/null' <bar> edit!

nnoremap gy "*yy
nnoremap gp "*pp

" FZF
nnoremap <leader>ff :Files<CR>
nnoremap <leader>fg :Rg<CR>
nnoremap <leader>fa :GFiles<CR>
nnoremap <leader><Space> :Buffers<CR>

" LSP
nnoremap gD :LspGotoDeclaration<CR>
nnoremap K :LspHover<CR>
nnoremap gra :LspCodeAction<CR>

set so=7

let $LANG='en'
set langmenu=en
set wildmenu

set wildignore=*.o,*~,*.pyc
set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store

set clipboard=unnamedplus
set ruler
set cmdheight=1
set foldcolumn=1
set hid
set ignorecase
set smartcase
set hlsearch
set incsearch
set lazyredraw
set magic
set showmatch
set mat=2
set number
set relativenumber
set cursorline

set noerrorbells
set novisualbell
set t_vb=
set tm=500

colorscheme substrata

syntax on

set list
set listchars=tab:..,trail:_,extends:>,precedes:<,nbsp:~

set nobackup
set nowb
set noswapfile

set lbr
set tw=500
set ai
set si
set nowrap

aug i3config_ft_detection
    au!
    au BufNewFile,BufRead ~/.config/i3/config set filetype=i3config
aug end

aug init
    au!

    " Close preview and command windows with q
    au BufWinEnter * if &previewwindow | nnoremap <buffer> q <C-W>q | endif
    au CmdWinEnter * nnoremap <buffer> q <C-W>q

    " Hide cursorline when the current window doesn't have focus
    au WinLeave,FocusLost * if !&diff && !&cursorbind | setlocal nocursorline | endif
    au WinEnter,FocusGained * setlocal cursorline

    " Disable listchars in prompt buffers
    au OptionSet buftype if &buftype ==# 'prompt' | setlocal nolist | endif

    " Don't show trailing spaces in insert mode
    au InsertEnter * setlocal listchars-=trail:_
    au InsertLeave * setlocal listchars<
aug end

call LspAddServer([#{name: 'clangd',
        \          filetype: ['c', 'cpp'],
        \          path: '/usr/bin/clangd',
        \          args: [],
        \          syncInit: v:true
        \       }])
call LspAddServer([#{name: 'rustlang',
        \          filetype: ['rust'],
        \          path: '/usr/bin/rust-analyzer',
        \          args: [],
        \          syncInit: v:true
        \       }])
call LspAddServer([#{name: 'elixir',
        \          filetype: ['elixir', 'eelixir', 'heex', 'surface'],
        \          path: '/usr/share/elixir-ls/language_server.sh',
        \          args: [],
        \          syncInit: v:true
        \       }])
call LspAddServer([#{name: 'zls',
        \          filetype: ['zig'],
        \          path: '/usr/bin/zls',
        \          args: [],
        \          syncInit: v:true
        \       }])
call LspAddServer([#{name: 'bash-language-server',
        \          filetype: ['sh'],
        \          path: '/usr/bin/bash-language-server',
        \          args: ["start"],
        \          syncInit: v:true
        \       }])

let g:lightline = {
    \ 'colorscheme': 'nord'
\ }
