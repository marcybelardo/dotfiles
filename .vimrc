set termguicolors
set encoding=utf8
set history=500

execute pathogen#infect()
packadd lsp

filetype plugin on
filetype indent on

set autoread
au FocusGained,BufEnter * silent! checktime

let mapleader="\<Space>"

nmap <leader>w :w!<cr>
command! W execute 'w !sudo tee % > /dev/null' <bar> edit!

" FZF
nnoremap <leader>fa :Files<cr>
nnoremap <leader>fg :Rg<cr>
nnoremap <leader>ft :GFiles<cr>
nnoremap <leader>fb :Buffers<cr>

" LSP
nnoremap <leader>gca :LspCodeAction<cr>
nnoremap <leader>gd :LspGotoDefinition<cr>
nnoremap <leader>gD :LspDiag nextWrap<cr>

" Nerdtree
nnoremap <leader>n :NERDTreeFocus<cr>
nnoremap <C-n> :NERDTree<cr>
nnoremap <C-t> :NERDTreeToggle<cr>
nnoremap <C-f> :NERDTreeFind<cr>

nnoremap <leader>x :bd<cr>

set so=7

let $LANG='en'
set langmenu=en
set wildmenu

set wildignore=*.o,*~,*.pyc
set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store

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

set background=dark
let g:everforest_background = "hard"
let g:everforest_better_performance = 1
colorscheme everforest
let g:airline_theme='everforest'

syntax on

set list
set listchars=tab:..,trail:_,extends:>,precedes:<,nbsp:~,leadmultispace:▏\ \ \ 

set nobackup
set nowb
set noswapfile

set expandtab
set smarttab
set shiftwidth=4
set tabstop=4
set lbr
set tw=500
set ai
set si
set wrap

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
call LspAddServer([#{name: 'clangd',
        \          filetype: ['c', 'cpp'],
        \          path: '/usr/bin/clangd',
        \          args: [],
        \          syncInit: v:true
        \       }])
call LspAddServer([#{name: 'zls',
        \          filetype: ['zig'],
        \          path: '/usr/bin/zls',
        \          args: [],
        \          syncInit: v:true
        \       }])
