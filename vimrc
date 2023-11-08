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
Plug 'tpope/vim-rails'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-bundler'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'scrooloose/syntastic'
Plug 'junegunn/fzf.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'kana/vim-textobj-user'
Plug 'nelstrom/vim-textobj-rubyblock'
Plug 'sainnhe/sonokai'
Plug 'airblade/vim-gitgutter'
Plug 'preservim/nerdtree'
call plug#end()

augroup vimplug 
  autocmd!

  au filetype vim-plug nnoremap <buffer> q :q<CR>
augroup end

" -----------
" colorscheme
" -----------
syntax enable
" set background=dark
" colorscheme solarized

if has('termguicolors')
  set termguicolors
endif

let g:sonokai_style = 'andromeda'
let g:sonokai_better_performance = 1
colorscheme sonokai

" --------
" Mappings
" --------
let mapleader="\<Space>"

nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l
nnoremap <leader>e :Ex<cr>
nnoremap <leader>ev :tabe $MYVIMRC<cr>
nnoremap <leader>sv :w $MYVIMRC<CR>:source $MYVIMRC<cr>
nnoremap <leader>pi :PlugInstall<cr>
nnoremap <leader>o :q<cr>
nnoremap <leader>ff :Files<CR>
nnoremap <leader>fg :GFiles<CR>
nnoremap <leader>fw :Rg<CR>
nnoremap <leader>ft :Tags<CR>
nnoremap <leader>fh :History<CR>
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>

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
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nnoremap <silent> K :call ShowDocumentation()<CR>
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
nmap <leader>rn <Plug>(coc-rename)
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>qf  <Plug>(coc-fix-current)
" tab
inoremap <silent><expr> <Tab>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
" shift-tab
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"
" enter
inoremap <silent><expr> <cr> coc#pum#visible() ? coc#_select_confirm() : "\<C-g>u\<CR>"
augroup coc
  autocmd!

  autocmd CursorHold * silent call CocActionAsync('highlight')
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" use <tab> to trigger completion and navigate to the next complete item
function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

command! -nargs=0 Format :call CocActionAsync('format')
command! -nargs=0 Prettier :CocCommand prettier.forceFormatDocument
