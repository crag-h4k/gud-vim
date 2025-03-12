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
" Basic UI settings ===========================
set wrap
set number
set ruler
set mouse+=a
set clipboard=unnamed
set updatetime=500
" Searching ===========================
set ignorecase
set smartcase
set incsearch
set autowrite
set hidden
" Remaps ===========================
" MacBook Touchbar
inoremap fj <ESC>
cnoremap fj <ESC>
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
" ALE ===========================
set omnifunc=ale#completion#OmniFunc
let g:ale_completion_enabled = 1
" other fun symbols
" '⚠' '☂' '☣' '☠'
let g:ale_sign_warning = '⚠'
let g:ale_sign_error = '☠'
" removed 'pylint' from python
let b:ale_linters={
\   'python': ['flake8', 'pylint', 'isort', 'darglint'],
\   'rust': ['analyzer'],
\   'yaml': ['cfn-lint', 'yamllint', 'cfn_nag_scan'],
\   'dockerfile': ['hadolint'],
\   'terraform': ['tflint'],
\   'markdown': ['markdownlint'],
\   'sql': ['sqlint', 'sql-lint'],
\}
let g:ale_fixers = {
\   'rust': ['rustfmt', 'trim_whitespace', 'remove_trailing_lines'],
\   'python': ['trim_whitespace', 'remove_trailing_lines'],
\}
" Set this in your vimrc file to disabling highlighting
" let g:ale_set_highlights = 0
"  Python Stuff ===========================
" PEP 8 Indentation
au BufNewFile, BufRead *.py set expandtab
set fileformat=unix
set omnifunc=pythoncomplete#Complete
let g:python_highlight_all = 1
let g:pymode_indent = 0
" let g:ale_python_flake8_options = '--ignore=E501 --append-config ~/.config/flake8'
let g:ale_python_flake8_options = '--append-config ~/.config/flake8'
" ignore invalid-name convention
let g:ale_python_pylint_options = '--ignore=C0103'
let g:python_host_prog='$HOME/.vim/venv/bin/python'
let g:python3_host_prog='$HOME/.vim/venv/bin/python3'
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
" Set Custom Ignore filetypes ===========================
" JSON Ignore (.jsoni)
autocmd BufNewFile,BufRead *.jsoni set filetype=json
" Python Ignore (.pyi)
autocmd BufNewFile,BufRead *.pyi set filetype=python
" Terraform Ignore (.tfi)
autocmd BufNewFile,BufRead *.tfi set filetype=terraform
" Yaml Ignore (.yamli, .ymli
autocmd BufNewFile,BufRead *.yamli,*.ymli set filetype=yaml
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
" Displays '-' for trailing space, '>-' for tabs and '_' for non breakable space
set listchars=tab:>-,trail:-,nbsp:_
set list
" No Noise ===========================
set noerrorbells
set novisualbell
set belloff=all
set tm=500
"  Typos ===========================
command! Q q
command! W w
command! WQ wq
command! Wq wq
" Get rid of empty lines
command! Blanks g/^\s*$/d
" Get rid of trailing spaces
command! WS %s/\s\+$//e
" Rainbow Tabs ===========================
let g:rainbow_active=1
" supertab ===========================
let g:SuperTabDefaultCompletionType = "<c-n>"
set splitright
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
" Status Line =============================
let g:lightline = { 'colorscheme': 'darcula' }
let g:airline#extensions#ale#enabled = 1
set laststatus=2
set statusline+=%#warningmsg#
set statusline+=%*
" Markdown ===============================
augroup markdown_fix
    au!
    au FileType markdown setlocal ts=4 sts=4 sw=4 textwidth=80
    " au FileType markdown setlocal ts=4 sts=4 sw=4 textwidth=80 formatoptions+=a
    au BufRead,BufNewFile *.md,*.mdi set filetype=markdown
    let g:ale_markdown_markdownlint_options = '--ignore=MD013'
    let g:vim_markdown_folding_disabled = 1
    let g:markdown_fenced_languages = [
          \ 'css',
          \ 'erb=eruby',
          \ 'go',
          \ 'html',
          \ 'javascript',
          \ 'js=javascript',
          \ 'json=javascript',
          \ 'markdown',
          \ 'ruby',
          \ 'sass',
          \ 'sh',
          \ 'sql',
          \ 'vim',
          \ 'xml',
          \ 'zsh',
          \ 'yaml'
      \ ]
augroup END" log-highlighting =======================
" au rc Syntax log syn keyword logLevelError test
let g:ale_set_highlights = 0
let g:LanguageClient_useVirtualText = 0
" YAML specific ===========================
"    Fix auto-indentation for YAML files
augroup yaml_fix
    au!
    au FileType yaml setlocal ts=2 sts=2 sw=2 expandtab indentkeys-=0# indentkeys-=<:>
    au BufRead,BufNewFile *.template.yaml,cfn.yaml set filetype=yaml.cloudformation
    let g:ale_yaml_yamllint_options='-d "{extends: relaxed, rules: {line-length: disable}}"'
augroup END
" OPA Rego Specific =======================
let g:formatdef_rego = '"opa fmt"'
let g:formatters_rego = ['rego']
let g:autoformat_autoindent = 0
let g:autoformat_retab = 0
" au BufWritePre *.rego Autoformat
" Functions ===========================
" xnoremap <leader>ips :s/0\+\([0-9a-f]\)/\1/ | *sort n /.*\./ | *sort n /\.\d\+\./ | *sort n /\./ | *sort n u
command Rando g/^/exec "move " .. rand() % (line('.'))
" Copilot ===========================
" I have filetypes disabled by default.
" To enable specific filetypes, add them to the dictionary below.
let g:copilot_filetypes = {
    \ '*': v:false,
    \ 'gitcommit': v:true,
    \ 'lua': v:true,
    \ 'markdown': v:true,
    \ 'vim': v:true,
    \ 'yaml': v:true,
    \ }
" Live Diff Updates ===========================
autocmd CursorMoved,CursorMovedI * diffupdate
" Deoplete ===========================
" let g:deoplete#enable_at_startup = 1
" Deoplete Terraform ===========================
" let g:deoplete#omni_patterns = {}

" call deoplete#custom#option('omni_patterns', {
" \ 'complete_method': 'omnifunc',
" \ 'terraform': '[^ *\t"{=$]\w*',
" \})

"call deoplete#initialize()
" let g:vimwiki_folding = 'custom'
set foldmethod=manual
set foldlevelstart=99
