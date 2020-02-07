"
runtime bundle/vim-pathogen/autoload/pathogen.vim
execute pathogen#infect()
syntax on
filetype plugin indent on
filetype plugin on 
set clipboard=unnamed

" * Colors *===========================
set t_Co=256
colorscheme dracula
set encoding=utf-8
"
"set omnifunc=syntaxcomplete#Complete
set runtimepath+=~/.vim
set number
set mouse+=a
"set clipboard=unnamed
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
" set textwidth=79
set expandtab
set autoindent
set fileformat=unix
set omnifunc=pythoncomplete#Complete
let python_highlight_all=1
"
"au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/
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
" * Default Indent *===========================
set ai
set si
set wrap
set autoindent
"
" * Noise *===========================
set noerrorbells
set novisualbell
set tm=500
"
" * Typos *===========================
command! Q q
command! W w
command! WQ wq
command! Wq wq
"
"* Plug-in Options *===========================
let g:rainbow_active = 1 "0 if you want to enable it later via :RainbowToggle 
let g:SuperTabDefaultCompletionType = "<c-n>"
set updatetime=500
let g:macdown_marked_programme = "misaka"
let g:jedi#show_call_signatures = "1"
let g:jedi#use_splits_not_buffers = "right"
"let g:airline_theme = 'dracula'
let g:airline_powerline_fonts = 1
" let g:airline_statusline_ontop = 1
""* Plug-in Repos *===========================
" 
""* Removed Submodules *===========================
" vim-javascript
" vim-misc
" vim-notes
" vim-ruby
" vim-yankstack
" [submodule "bundle/ale"]
" 	path = bundle/ale
" 	url = https://github.com/w0rp/ale
" [submodule "bundle/jedi-vim"]
"	path = bundle/jedi-vim
"	url = https://github.com/davidhalter/jedi-vim
" [submodule "bundle/nerdcommenter"]
"	path = bundle/nerdcommenter
"	url = https://github.com/scrooloose/nerdcommenter
"[submodule "bundle/nerdtree"]
"	path = bundle/nerdtree
"	url = https://github.com/scrooloose/nerdtree
" [submodule "bundle/rust.vim"]
"	path = bundle/rust.vim
"	url = https://github.com/rust-lang/rust.vim
" [submodule "bundle/syntastic"]
"	path = bundle/syntastic
"	url = https://github.com/vim-syntastic/syntastic
" [submodule "bundle/vim-javascript"]
"	path = bundle/vim-javascript
"	url = https://github.com/pangloss/vim-javascript
" [submodule "bundle/vim-ruby"]
" 	path = bundle/vim-ruby
"	url = https://github.com/vim-ruby/vim-ruby
" [submodule "bundle/vim-yankstack"]
" 	path = bundle/vim-yankstack
"	url = https://github.com/maxbrunsfeld/vim-yankstack
" [submodule "bundle/vim-notes"]
"	path = bundle/vim-notes
"	url = https://github.com/xolox/vim-notes.git
" [submodule "bundle/vim-misc"]
" 	path = bundle/vim-misc
"	url = https://github.com/xolox/vim-misc
