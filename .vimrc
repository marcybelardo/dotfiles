set termguicolors
set encoding=utf8
set history=500

call plug#begin()

" tpope
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-vinegar'

" junegunn
Plug 'junegunn/fzf.vim'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'

" colorschemes
Plug 'zenbones-theme/zenbones.nvim'
Plug 'sainnhe/gruvbox-material'
Plug 'sainnhe/everforest'
Plug 'sainnhe/edge'

" ui
Plug 'itchyny/lightline.vim'
Plug 'airblade/vim-gitgutter'

" filetypes
Plug 'elixir-editors/vim-elixir'
Plug 'ziglang/zig.vim'
Plug 'bfrg/vim-c-cpp-modern'
Plug 'elkowar/yuck.vim'
Plug 'justinj/vim-pico8-syntax'

" writing
Plug 'preservim/vim-pencil'

" snippets
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

call plug#end()

packadd lsp

set background=dark

" let g:gruvbox_material_background='hard'
" let g:gruvbox_material_better_performance=1
" colorscheme gruvbox-material

" let g:edge_style='aura'
" let g:edge_dim_foreground=0
" let g:edge_better_performance=1
" colorscheme edge

let g:everforest_background='hard'
let g:everforest_better_performance=1
colorscheme everforest

let g:lightline = {
        \ 'colorscheme': 'gruvbox_material',
        \ 'active': {
        \   'left': [ [ 'mode', 'paste' ],
        \             [ 'filename', 'readonly', 'gitbranch', 'modified' ] ]
        \ },
        \ 'component_function': {
        \   'gitbranch': 'FugitiveHead'
        \ },
        \ }

let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<C-b>"
let g:UltiSnipsJumpBackwardTrigger="<C-z>"

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
nnoremap grd :LspDiag show<CR>
nnoremap gra :LspCodeAction<CR>

" Lights!
nnoremap <leader>ll :Limelight!!<CR>
nnoremap <leader>lg :Goyo<CR>

filetype plugin indent on
set autoread

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

syntax on

set list
set listchars=tab:>\ ,leadmultispace:·\ \ \ ,trail:_,extends:>,precedes:<,nbsp:~
set showbreak=\\ " [bonus]

set nobackup
set nowb
set noswapfile

set lbr
set tw=500
set ai
set si
set nowrap

let g:pencil#wrapModeDefault='soft'
aug pencil
    au!
    au FileType markdown,mkd call pencil#init()
    au FileType text         call pencil#init()
aug end

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

au! User GoyoEnter Limelight
au! User GoyoLeave Limelight!

call LspAddServer([#{name: 'clangd',
        \          filetype: ['c', 'cpp'],
        \          path: '/usr/bin/clangd',
        \          args: [],
        \          syncInit: v:true
        \       }])
call LspAddServer([#{name: 'rust-analyzer',
        \          filetype: ['rust'],
        \          path: '/home/marcy/.cargo/bin/rust-analyzer',
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
call LspAddServer([#{name: 'gopls',
        \          filetype: ['go'],
        \          path: '/usr/bin/gopls',
        \          args: [],
        \          syncInit: v:true
        \       }])
