set nocompatible
set clipboard=unnamedplus
syntax on
filetype plugin indent on
set tabstop=4
set shiftwidth=4
set expandtab
set guioptions-=m
set guioptions-=T
set noesckeys
set relativenumber
set number
set ignorecase
set smartcase
set incsearch
set cinoptions=l1
set modeline
set keymap=russian-jcukenwin
set iminsert=0
set imsearch=0
" colorscheme habamax

autocmd FileType go setlocal tabstop=4 shiftwidth=4 expandtab
autocmd BufEnter * if &filetype == "go" | setlocal noexpandtab

let g:rustfmt_autosave = 0
let g:rustfmt_emit_files = 0
let g:rustfmt_fail_silently = 0
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

inoremap jj <esc>
vnoremap oo <esc>

let b:coc_suggest_disable = 1
inoremap <M-]> <C-x><C-o>

set path+=**
set wildmenu
set wildmode=list:longest,full

nnoremap <C-m> :make<CR>
nnoremap <C-c> :cope<CR>

nnoremap <M-h> :wincmd h<CR>
nnoremap <M-j> :wincmd j<CR>
nnoremap <M-k> :wincmd k<CR>
nnoremap <M-l> :wincmd l<CR>

inoremap <C-h> <Left>
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-l> <Right>

nnoremap <C-=> :vertical resize -2<CR>
nnoremap <C--> :vertical resize +2<CR>
nnoremap <C-;> :resize -2<CR>
nnoremap <C-'> :resize +2<CR>

noremap <S-d> :Ex<CR>

set splitright

inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
inoremap <expr> <Enter> pumvisible() ? "\<C-y>" : "\<CR>"
inoremap <expr> <Esc> pumvisible() ? "\<C-e>" : "\<Esc>"
let g:lsp_signature_enabled = 0

nnoremap <C-x>3 :vsplit<CR>

"noremap <M-.> <Plug>(coc-definition)<CR>
noremap <C-]> :call CocActionAsync('jumpDefinition') <CR>
noremap <C-t> <C-o>

set noexpandtab
set tabstop=2
set shiftwidth=2
set softtabstop=2

call plug#begin('~/.vim/plugged')
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'tpope/vim-fugitive'
Plug 'mg979/vim-visual-multi'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
call plug#end()
