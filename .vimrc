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
Plug 'lunacookies/vim-substrata'
Plug 'nordtheme/vim'
Plug 'zenbones-theme/zenbones.nvim'

" ui
Plug 'itchyny/lightline.vim'
Plug 'airblade/vim-gitgutter'

call plug#end()

packadd lsp

set background=dark
colorscheme kanagawa
let g:lightline = { 'colorscheme': 'duckbones' }

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

" Lights!
nnoremap <leader>ll :Limelight!!<CR>
nnoremap <leader>lg :Goyo<CR>

" netrw
nnoremap <leader>dd :Lexplore %:p:h<CR>
nnoremap <leader>da :Lexplore<CR>

function! NetrwRemoveRecursive()
        if &filetype ==# 'netrw'
                cnoremap <buffer> <CR> rm -r<CR>
                normal mu
                normal mf

                try
                        normal mx
                catch
                        echo "cancelled"
                endtry

                cunmap <buffer> <CR>
        endif
endfunction

function! NetrwMapping()
        " go back in the directory
        nmap <buffer> H u
        " go up in the directory
        nmap <buffer> h -^
        " open a directory or file
        nmap <buffer> l <CR>

        " toggle dotfiles
        nmap <buffer> . gh
        " close preview window
        nmap <buffer> P <C-w>z

        " open a file and close netrw
        nmap <buffer> L <CR>:Lexplore<CR>
        " close netrw
        nmap <buffer> <leader>dd :Lexplore<CR>

        " mark file or directory
        nmap <buffer> <Tab> mf
        " unmark all files in current buffer
        nmap <buffer> <S-Tab> mF
        " remove all marks on all files
        nmap <buffer> <leader><Tab> mu

        " create a file
        nmap <buffer> ff %:w<CR>:buffer #<CR>
        " rename a file
        nmap <buffer> fe R
        " copy marked files
        nmap <buffer> fc mc
        " assign the target dir and copy in one step
        nmap <buffer> fC mtmc
        " move marked files
        nmap <buffer> fx mm
        " assign the target dir and move in one step
        nmap <buffer> fX mtmm
        " for running external commands on marked files
        nmap <buffer> f; mx

        " show list of marked files
        nmap <buffer> fl :echo join(netrw#Expose("netrwmarkfilelist"), "\n")<CR>

        " recursively delete files
        nmap <buffer> FF :call NetrwRemoveRecursive()<CR>
endfunction

aug netrw_mapping
        au!
        au FileType netrw call NetrwMapping()
aug end

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
set listchars=tab:>\ ,trail:_,extends:>,precedes:<,nbsp:~
set showbreak=\\ " [bonus]

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

    " Automatically close vim if NERDTree is the only window remaining
    au BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | call feedkeys(":quit\<CR>:\<BS>") | endif
aug end

au! User GoyoEnter Limelight
au! User GoyoLeave Limelight!

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
