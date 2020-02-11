"
runtime bundle/vim-pathogen/autoload/pathogen.vim
execute pathogen#infect()
set runtimepath+=~/.vim
syntax on
filetype plugin indent on
filetype plugin on 
" * Colors *===========================
set t_Co=256
colorscheme dracula
set encoding=utf-8
"
set number
set mouse+=a
set clipboard=unnamed
" 
" * Searching *===========================
set ignorecase
set smartcase
set incsearch
set autowrite
set hidden
"
" * Remaps *===========================
"
"MacBook Touchbar
inoremap fj <ESC>
cnoremap fj <ESC>
"Search and Replace
nmap sr <ESC>:%s///gc
"Delete all below current line
nmap db <ESC>:+,$d
" set buffers to leave off where left
nnoremap <Space> za
vnoremap <Space> za
"""""Refocus fold
nnoremap ,z zMzvzz
""""unfold top regardless of cursor location
"
" * Folding *===========================
set foldmethod=indent
set foldnestmax=10
set foldlevel=0
set nofoldenable
"
" Buffer *===========================
"buffers to save cursor location
au BufWinLeave * mkview
au BufWinEnter * silent loadview
"
" Security *===========================
" remember :X to encrypt, to remove passwd :X and leave blank
setlocal cm=blowfish2 
set noswapfile
set nobackup
set nowritebackup
"
"fix backspace errors
set backspace=indent,eol,start
"
set wildmenu
set wildmode=list:longest,full
"
" * Python Stuff *===========================
" PEP 8 Indentation
au BufNewFile, BufRead *.py
set tabstop=4
set ts=4
set softtabstop=4
set shiftwidth=4
set expandtab
set autoindent
set fileformat=unix
set omnifunc=pythoncomplete#Complete
let python_highlight_all=1
"
" * Tabbing *===========================
set smarttab
set shiftwidth=4
set tabstop=4
set softtabstop=4
set expandtab
nnoremap<C-S-Enter> :tabe<CR>
nnoremap<C-S-tab> :tabp<CR>
nnoremap<C-tab>   :tabn<CR>
" * Default Indent *=====================
set ai
set si
set wrap
set autoindent
"
" * Noise *===========================
set noerrorbells
set novisualbell
set belloff=all
set tm=500
" * Typos *===========================
command! Q q
command! W w
command! WQ wq
command! Wq wq
"
"* Plug-in Options *===========================
" remap nerdtree to Ctrl + n
map <C-n> :NERDTreeToggle<CR>
let g:rainbow_active=1
let g:SuperTabDefaultCompletionType = "<c-n>"
set updatetime=500
let g:jedi#show_call_signatures = "1"
let g:jedi#use_splits_not_buffers = "right"
let g:NERDTreeIndicatorMapCustom = {
    \ "Modified"  : "♻",
    \ "Staged"    : "✚",
    \ "Untracked" : "✭",
    \ "Renamed"   : "➜",
    \ "Unmerged"  : "═",
    \ "Deleted"   : "✖",
    \ "Dirty"     : "☭",
    \ "Clean"     : "♥",
    \ 'Ignored'   : '☹',
    \ "Unknown"   : "?"
    \ }
" * Status Line *=============================
let g:lightline = {
      \ 'colorscheme': 'darcula',
      \ }
set laststatus=2
