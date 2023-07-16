" --------
" Settings
" --------
set nowrap
set number
set ruler
set showmatch
set linespace=2
set laststatus=2
set showtabline=2
set showcmd
set cmdheight=2
set switchbuf=useopen
set relativenumber
set splitbelow
set splitright
set mouse=a

" tab completion
set wildmenu
set wildmode=longest,list
set wildignore=tmp,node_modules,generated,dist

" whitespace
set autoindent
set tabstop=2
set shiftwidth=2
set softtabstop=2
set smarttab
set expandtab
set shiftround
set list
set listchars=tab:▸\ ,trail:·,extends:⇒,precedes:⇐

" search
set hlsearch
set ignorecase
set smartcase
set incsearch

set shell=zsh

filetype plugin on

" --------
" Plugins
" --------
call plug#begin()
" Plug 'altercation/vim-colors-solarized'
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-bundler'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'scrooloose/syntastic'
Plug 'junegunn/fzf.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Plug 'dense-analysis/ale'
call plug#end()

" -----------
" colorscheme
" -----------
syntax enable
" set background=dark
" colorscheme solarized

" --------
" Mappings
" --------
let mapleader="\<Space>"

nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l
nnoremap <leader>ev :tabe $MYVIMRC<cr>
nnoremap <leader>sv :w $MYVIMRC<CR>:source $MYVIMRC<cr>
nnoremap <leader>pi :PlugInstall<cr>
nnoremap <leader>o :q<cr>
nnoremap <leader>ff :Files<CR>
nnoremap <leader>fg :GFiles<CR>
nnoremap <leader>fw :Rg<CR>
nnoremap <leader>ft :Tags<CR>
nnoremap <leader>fh :History<CR>

" --------
" vim help
" --------
augroup vimhelp
  autocmd!

  au filetype help nnoremap <buffer> q :q<CR>
  au filetype help setlocal nonumber
augroup end

" ---
" ALE
" ---
" let g:ale_linters = {'ruby': ['standardrb']}
" let g:ale_fixers = {'ruby': ['standardrb']}
" let g:ale_sign_error = '●'
" let g:ale_sign_warning = '.'

" --------
" Coc.vim
" --------
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction
