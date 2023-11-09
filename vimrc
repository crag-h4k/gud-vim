" ===========================
" This is a gud vim setup. Remember to update the submodules in bundle/
" ===========================
runtime bundle/vim-pathogen/autoload/pathogen.vim
execute pathogen#infect()
set runtimepath+=~/.vim
syntax on
filetype plugin indent on
" Colors ===========================
set t_Co=256
set encoding=utf-8
colorscheme dracula
"
" Basic UI settings ===========================
set wrap
set number
set ruler
set mouse+=a
set clipboard=unnamed
set updatetime=500
"
" Searching ===========================
set ignorecase
set smartcase
set incsearch
set autowrite
set hidden
"
" Remaps ===========================
" MacBook Touchbar
inoremap fj <ESC>
cnoremap fj <ESC>
"
"
" Buffer ===========================
"    buffers to save cursor location
" au BufWinLeave mkview
" au BufWinEnter silent loadview
if has("autocmd")
      au BufReadPost if line("'\"") > 0 && line("'\"") <= line("$") | exe normal! g`\"" | endif
endif
" Buffer ===========================
" set buffers to leave off where left
" au BufWinLeave * mkview
" buffers to save cursor location
" au BufWinEnter * silent loadview
if has("autocmd")
      au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
  endif
"
" Security ===========================
set noswapfile
set nobackup
set nowritebackup
" Remember :X to encrypt, to remove passwd :X and leave blank
"    If not using neovim, set cryptmethod to blowfish2
if !has('nvim')
    setlocal cm=blowfish2
endif
"
" Fix backspace errors ===========================
set backspace=indent,eol,start
"
set wildmenu
set wildmode=list:longest,full
"
" ALE ===========================
set omnifunc=ale#completion#OmniFunc
" let g:ale_completion_enabled = 0
" other fun symbols
" '⚠' '☂' '☣' '☠'
let g:ale_sign_warning = '⚠'
let g:ale_sign_error = '☠'
" Check Python files with flake8 and pylint.

let b:ale_linters={
\   'python': ['flake8', 'darglint', 'pylint'],
\   'rust': ['analyzer'],
\   'yaml': ['cfn-lint', 'yamllint'],
\   'dockerfile': ['hadolint'],
\   'terraform': ['tflint'],
\}
" need to install rust analyyer, rustfmt
let g:ale_fixers = {
\   'rust': ['rustfmt', 'trim_whitespace', 'remove_trailing_lines'],
\   'python': ['trim_whitespace', 'remove_trailing_lines'],
\}
" Set this in your vimrc file to disabling highlighting
" let g:ale_set_highlights = 0
"
"  Python Stuff ===========================
" PEP 8 Indentation
au BufNewFile, BufRead *.py set expandtab
set fileformat=unix
set omnifunc=pythoncomplete#Complete
let g:python_highlight_all = 1
let g:pymode_indent = 0
let g:ale_python_flake8_options = '--ignore=E501'
" ignore invalid-name convention
let g:ale_python_pylint_options = '--ignore=C0103'
"
" Rust Stuff ===========================
autocmd BufNewFile,BufRead *.rs set filetype=rust
" Go Stuff ===========================
autocmd BufNewFile,BufRead *.go set filetype=go
" Dockerfile
autocmd BufNewFile,BufRead *Dockerfile* set filetype=dockerfile
" BUCK2 and Starklark
autocmd BufNewFile,BufRead BUCK set filetype=starlark
" Jenkinsfile
augroup set_jenkins_groovy
    au!
    au BufNewFile,BufRead *.jenkinsfile,*.Jenkinsfile,Jenkinsfile,jenkinsfile setf groovy
    "autocmd BufWritePost Jenkinsfile !ssh localhost -p1337 declarative-linter < %
augroup END

"
"  Tabbing and Indents ===========================
set smarttab
set expandtab
" copy indent from current line when starting a new line
set autoindent
set smartindent
set cindent
set tabstop=4
set softtabstop=4
set shiftwidth=4
" Tab remaps
nnoremap<C-S-Enter> :tabe<CR>
nnoremap<C-S-tab> :tabp<CR>
nnoremap<C-tab>   :tabn<CR>
" YAML specific ===========================
"    Fix auto-indentation for YAML files
augroup yaml_fix
    au!
    au FileType yaml setlocal ts=2 sts=2 sw=2 expandtab indentkeys-=0# indentkeys-=<:>
    au BufRead,BufNewFile *.template.yaml,cfn.yaml set filetype=yaml.cloudformation
augroup END
"
" Displays '-' for trailing space, '>-' for tabs and '_' for non breakable space
set listchars=tab:>-,trail:-,nbsp:_
set list
"
" No Noise ===========================
set noerrorbells
set novisualbell
set belloff=all
set tm=500
"
"  Typos ===========================
command! Q q
command! W w
command! WQ wq
command! Wq wq
"
" Rainbow Tabs ===========================
let g:rainbow_active=1
" supertab ===========================
let g:SuperTabDefaultCompletionType = "<c-n>"
"
" Jedi ===========================
set omnifunc=jedi
let g:jedi#show_call_signatures = "1"
set splitright
let g:jedi#use_splits_not_buffers = "right"
let g:jedi#completor_python_binary='$HOME/.vim/venv/bin/python'
" let g:completor_python_binary='$HOME/.vim/venv/bin/python'
let g:python_host_prog='$HOME/.vim/venv/bin/python'
let g:python3_host_prog='$HOME/.vim/venv/bin/python3'
let g:jedi#environment_path = "venv"
let g:jedi#auto_initialization = 1
let g:jedi#completions_enabled = 1
let g:jedi#auto_vim_configuration = 1
" let g:jedi#smart_auto_mappings = 0
let g:jedi#popup_on_dot = 1
" let g:jedi#completions_command = "<M-<tab>>"
let g:jedi#show_call_signatures = "1"
let g:jedi#show_call_signatures_delay = 0
" let g:jedi#show_call_signatures_modes = 'ni'  ni = also in normal mode
let g:jedi#enable_speed_debugging= 1
"
" NERDTree  ===========================
" remap nerdtree to Ctrl + n
map <C-n> :NERDTreeToggle<CR>
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
" Status Line =============================
let g:lightline = { 'colorscheme': 'darcula' }
let g:airline#extensions#ale#enabled = 1
set laststatus=2
set statusline+=%#warningmsg#
set statusline+=%*
"
" Instant Markdown =======================
" set shell=bash\ -i
"
" log-highlighting =======================
" au rc Syntax log syn keyword logLevelError test
let g:ale_set_highlights = 0
let g:LanguageClient_useVirtualText = 0
"
