"
runtime bundle/vim-pathogen/autoload/pathogen.vim
execute pathogen#infect()
set runtimepath+=~/.vim
syntax on
filetype plugin indent on
let g:python_host_prog='$HOME/.vim/venv/bin/python2'
let g:python3_host_prog='$HOME/.vim/venv/bin/python3'
" * Colors *===========================
set t_Co=256
set encoding=utf-8
colorscheme dracula
"
" Misc settings
set wrap
set number
set ruler
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
"MacBook Touchbar
inoremap fj <ESC>
cnoremap fj <ESC>
"
" set buffers to leave off where left
nnoremap <Space> za
vnoremap <Space> za
"""""Refocus fold
nnoremap ,z zMzvzz
""""unfold top regardless of cursor location
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
if has("autocmd")
      au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
  endif
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
" ALE
set omnifunc=ale#completion#OmniFunc
" let g:ale_completion_enabled = 0
" other fun symbols
" '⚠' '☂' '☣' '☠'
let g:ale_sign_warning = '☠'
let g:ale_sign_error = '⚠'
" Check Python files with flake8 and pylint.
let b:ale_linters = ['flake8', 'pylint']
"
" * Python Stuff *===========================
" PEP 8 Indentation
au BufNewFile, BufRead *.py set expandtab
set fileformat=unix
set omnifunc=pythoncomplete#Complete
let g:python_highlight_all = 1
"
" * Tabbing and Indents *===========================
let g:pymode_indent = 0
set smarttab
set expandtab
" copy indent from current line when starting a new line
set autoindent
"set smartindent
set cindent
set tabstop=4
set ts=4
set softtabstop=4
set shiftwidth=4
" Displays '-' for trailing space, '>-' for tabs and '_' for non breakable
" space
set listchars=tab:>-,trail:-,nbsp:_
set list
nnoremap<C-S-Enter> :tabe<CR>
nnoremap<C-S-tab> :tabp<CR>
nnoremap<C-tab>   :tabn<CR>
"
" * Turn off noise *===========================
set noerrorbells
set novisualbell
set belloff=all
set tm=500
"
" * Typos *===========================
command! Q q
command! W w
command! WQ wq
command! Wq wq
"
"* Plug-in Options *===========================
" NERDTree
" remap nerdtree to Ctrl + n
map <C-n> :NERDTreeToggle<CR>
let g:rainbow_active=1
let g:SuperTabDefaultCompletionType = "<c-n>"
set updatetime=500
"
" Jedi
" set omnifunc=jedi
let g:jedi#show_call_signatures = "1"
set splitright
let g:jedi#use_splits_not_buffers = "right"
let g:completor_python_binary='$HOME/.vim/venv/bin/python'
let g:jedi#auto_initialization = 1
let g:jedi#completions_enabled = 1
let g:jedi#auto_vim_configuration = 1
" let g:jedi#smart_auto_mappings = 0
let g:jedi#popup_on_dot = 1
" let g:jedi#completions_command = "<M-<tab>>"
let g:jedi#show_call_signatures = "1"
let g:jedi#show_call_signatures_delay = 0
" let g:jedi#show_call_signatures_modes = 'ni'  " ni = also in normal mode
let g:jedi#enable_speed_debugging= 1
let g:jedi#environment_path = "venv"
"
let g:NERDTreeGitStatusIndicatorMapCustom = {
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
"
" * Status Line *=============================
let g:lightline = { 'colorscheme': 'darcula' }
let g:airline#extensions#ale#enabled = 1
set laststatus=2
set statusline+=%#warningmsg#
set statusline+=%*
" packloadall
"
" * Instant Markdown *=======================
set shell=bash\ -i

