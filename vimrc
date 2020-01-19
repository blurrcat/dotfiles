call plug#begin('~/.vim/plugged')

" language packs
" elm
Plug 'antew/vim-elm-language-server'
" Plug 'ElmCast/elm-vim'
" Plug 'carmonw/elm-vim'
Plug 'Zaptic/elm-vim'
" elixir
Plug 'elixir-editors/vim-elixir'

Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'airblade/vim-gitgutter'
Plug 'altercation/vim-colors-solarized'
Plug 'mhartington/oceanic-next'
Plug 'rhysd/devdocs.vim'
Plug 'dbeniamine/cheat.sh-vim'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'ervandew/supertab'
Plug 'honza/vim-snippets'
Plug 'janko-m/vim-test'
Plug 'tpope/vim-dispatch'
Plug 'Glench/Vim-Jinja2-Syntax'
Plug 'mattn/emmet-vim'
Plug 'jremmen/vim-ripgrep'
Plug 'mxw/vim-jsx'
Plug 'octref/RootIgnore'
Plug 'pearofducks/ansible-vim'
Plug 'raimondi/delimitmate'
Plug 'SirVer/ultisnips'
" Linter
Plug 'w0rp/ale'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" python
" Plug 'davidhalter/jedi-vim'
Plug 'hynek/vim-python-pep8-indent'
" typescript
Plug 'leafgarland/typescript-vim'
" stylus
Plug 'wavded/vim-stylus'
" golang
" Plug 'fatih/vim-go'
" rust
" Plug 'racer-rust/vim-racer'
" Plug 'rust-lang/rust.vim'

call plug#end()

filetype plugin indent on
set nocompatible
set bs=indent,eol,start
set encoding=utf-8
syntax enable
set number
set hidden
set ignorecase
set smartcase
set expandtab
set tabstop=4
set shiftwidth=4
set autoindent
set ttimeoutlen=0
set splitright
set colorcolumn=80
set foldmethod=indent

" mouse
set mouse=a

" undo
set undodir=~/.vim/undodir
set undofile
set undolevels=1000
set undoreload=10000

if (has("termguicolors"))
    set termguicolors
endif

set background=dark
colorscheme OceanicNext

" spell
fun! SpellCheck()
    setlocal spell
    syntax match UrlNoSpell '\w\+:\/\/[^[:space:]]\+' contains=@NoSpell
    syntax match AcronymNoSpell '\<\(\u\|\d\)\{3,}s\?\>' contains=@NoSpell
endfun
autocmd FileType markdown,text :call SpellCheck()

" airline
let g:airline_theme='oceanicnext'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline#extensions#tabline#buffer_idx_mode = 1
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
let g:airline#extensions#ale#enabled = 1
let g:airline_powerline_fonts=1
nmap <leader>1 <Plug>AirlineSelectTab1
nmap <leader>2 <Plug>AirlineSelectTab2
nmap <leader>3 <Plug>AirlineSelectTab3
nmap <leader>4 <Plug>AirlineSelectTab4
nmap <leader>5 <Plug>AirlineSelectTab5
nmap <leader>6 <Plug>AirlineSelectTab6
nmap <leader>7 <Plug>AirlineSelectTab7
nmap <leader>8 <Plug>AirlineSelectTab8
nmap <leader>9 <Plug>AirlineSelectTab9
nmap <leader>- <Plug>AirlineSelectPrevTab
nmap <leader>= <Plug>AirlineSelectNextTab
nmap <leader>x :bd<CR>
nmap <leader>p :b#<CR>

" nerdtree
map <C-n> :NERDTreeToggle<CR>
let NERDTreeRespectWildIgnore=1
let NERDTreeWinSize = 30
let NERDTreeQuitOnOpen = 1
let NERDTreeAutoDeleteBuffer = 1

" emmet
let g:user_emmet_settings = {
\  'javascript.jsx' : {
\      'extends' : 'jsx',
\  },
\  'javascript' : {
\      'extends' : 'jsx',
\  },
\}
let g:user_emmet_mode = 'a'

" ack
if executable('rg')
    " ctrlp
    let g:ctrlp_user_command = 'rg --files %s'
    set grepprg=rg\ --vimgrep
    set grepformat^=%f:%l:%c:%m
endif

" ctrlp
let g:ctrlp_use_caching = 0
let g:ctrlp_working_path_mode = 'w'
let g:ctrlp_custom_ignore = {
  \ 'dir': '\v[\/](htmlcov)',
  \ }
let g:elm_syntastic_show_warnings = 1
let g:elm_make_show_warnings = 1
let g:elm_format_autosave = 1

" Ale
" let g:ale_lint_on_enter = 0
let g:ale_lint_on_text_changed = 1
let g:ale_set_baloons = 1
let g:ale_completion_enabled = 1
let g:ale_command_wrapper = 'nice -n5'
let g:ale_list_window_size = 5
let g:ale_fixers = {
\    '*': ['remove_trailing_lines', 'trim_whitespace'],
\    'yaml.ansible': ['ansible'],
\    'javascript': ['eslint'],
\    'typescript': ['eslint'],
\    'css': ['prettier'],
\    'python': ['yapf'],
\}
let g:ale_fixers.elixir = ['mix_format']
let g:ale_linters = {}
let g:ale_linters_ignore = { 'elm': ['make'] }
let g:ale_linters.elixir = ['elixir-ls']
let g:ale_linters.python = ['pyls', 'flake8', 'mypy']
let g:ale_python_mypy_ignore_invalid_syntax = 1

let g:ale_elm_ls_use_global = 1
let g:ale_elixir_elixir_ls_release = $HOME . '/lib/elixir-ls'
nmap <silent> <C-b> <Plug>(ale_fix)
nmap <silent> <leader>D <Plug>(ale_detail)
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)
nmap <silent> <leader>K <Plug>(devdocs-under-cursor)
nmap <silent> <leader>d :ALEGoToDefinition<CR>
nmap <silent> <leader>r :ALEFindReferences<CR>
nmap <silent> <leader>k <Plug>(ale_hover)

" highlighting in elm code looks really bad
au FileType elm let g:ale_set_highlights = 0
let g:elm_setup_keybindings = 0

" vim-test<cr>
let g:test#runner_commands = ['PyTest']
let test#python#runner = 'pytest'
let test#go#runner = 'ginkgo'
let test#go#ginkgo#executable = 'ginkgo watch'
let test#go#ginkgo#options = '-skipMeasurements'
" let test#strategy = ''
nmap <silent> <leader>t :TestNearest<CR>
nmap <silent> <leader>T :TestFile<CR>
nmap <silent> <leader>a :TestSuite<CR>
nmap <silent> <leader>g :TestVisit<CR>
nmap <silent> <leader>l :TestLast<CR>

" auto-complete
" disable preview scratch window
set completeopt=menu,menuone,preview,noinsert,noselect
" set omnifunc=ale#completion#OmniFunc
set splitbelow
" limit popup menu height
set pumheight=15
let g:SuperTabDefaultCompletionType = 'context'

" ansible-vim
let g:ansible_name_highlight = 'b'
let g:ansible_attribute_highlight = 'a'

" search
set hlsearch incsearch

" rust
let g:racer_cmd = '~/.cargo/bin/racer'
let g:rustfmt_autosave = 1

if filereadable(expand('~/.vimrc.local'))
  source ~/.vimrc.local
endif
