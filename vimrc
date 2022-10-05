"
runtime bundle/vim-pathogen/autoload/pathogen.vim
" execute pathogen#infect()
call pathogen#infect()
set runtimepath+=~/.vim
syntax on
" filetype plugin on
filetype plugin indent on
let g:python_host_prog='$HOME/.vim/venv/bin/python2'
let g:python3_host_prog='$HOME/.vim/venv/bin/python3'
" * Colors *===========================
set t_Co=256
set encoding=utf-8
colorscheme dracula
" colorscheme wombat
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
"
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
" au BufWinLeave * mkview
"au BufWinEnter * silent loadview
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
let g:python_highlight_all = 1

"
" * Tabbing *===========================
set smartindent
set tabstop=4
set smarttab
set shiftwidth=4
set softtabstop=4
set expandtab
" Displays '-' for trailing space, '>-' for tabs and '_' for non breakable
" space
set listchars=tab:>-,trail:-,nbsp:_
set list
nnoremap<C-S-Enter> :tabe<CR>
nnoremap<C-S-tab> :tabp<CR>
nnoremap<C-tab>   :tabn<CR>
"
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
"
" * Typos *===========================
command! Q q
command! W w
command! WQ wq
command! Wq wq
"
"* Plug-in Options *===========================
" remap nerdtree to Ctrl + n
" NERDTree
map <C-n> :NERDTreeToggle<CR>
let g:rainbow_active=1
let g:SuperTabDefaultCompletionType = "<c-n>"
set updatetime=500
let g:jedi#show_call_signatures = "1"
let g:jedi#use_splits_not_buffers = "right"
"
" YouCompleteMe
" Use homebrew's clangd
" let g:ycm_clangd_binary_path = trim(system('brew --prefix llvm')).'/bin/clangd'
" let g:ycm_clangd_binary_path = '/usr/local/opt/llvm/bin/clangd'
"
" Syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_swift_checkers = ['swiftpm', 'swiftlint']
let g:syntastic_python_checkers = ['pylint']
let g:jedi#use_tabs_not_buffers=1
" let g:completor_python_binary='$HOME/.vim/venv/bin/python'
"
" Jedi
let g:jedi#auto_initialization = 1
let g:jedi#completions_enabled = 1
let g:jedi#auto_vim_configuration = 1
let g:jedi#smart_auto_mappings = 0
let g:jedi#popup_on_dot = 1
" let g:jedi#completions_command = ""
let g:jedi#show_call_signatures = "1"
let g:jedi#show_call_signatures_delay = 0
let g:jedi#use_tabs_not_buffers = 0
let g:jedi#show_call_signatures_modes = 'ni'  " ni = also in normal mode
let g:jedi#enable_speed_debugging=0
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
let g:lightline = {
      \ 'colorscheme': 'darcula',
      \ }
set laststatus=2
" packloadall
"
" * Instant Markdown *=======================
" set shell=bash\ -i

