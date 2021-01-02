call plug#begin('~/.vim/plugged')

" IDE
Plug 'SirVer/ultisnips'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'airblade/vim-gitgutter'
Plug 'altercation/vim-colors-solarized'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'dbeniamine/cheat.sh-vim'
Plug 'ervandew/supertab'
Plug 'honza/vim-snippets'
Plug 'janko-m/vim-test'
Plug 'jremmen/vim-ripgrep'
Plug 'junegunn/goyo.vim'
Plug 'mhartington/oceanic-next'
Plug 'natebosch/vim-lsc'
Plug 'octref/RootIgnore'
Plug 'raimondi/delimitmate'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-surround'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'w0rp/ale'

" tmux
Plug 'christoomey/vim-tmux-runner'

" language packs
Plug 'Glench/Vim-Jinja2-Syntax'
Plug 'andys8/vim-elm-syntax'
Plug 'elixir-editors/vim-elixir'
Plug 'leafgarland/typescript-vim'
Plug 'mattn/emmet-vim'
Plug 'mxw/vim-jsx'
Plug 'pearofducks/ansible-vim'
Plug 'wavded/vim-stylus'
Plug 'georgewitteman/vim-fish'


call plug#end()

" defaults
filetype plugin indent on
set autoindent
set backupcopy=yes
set bs=indent,eol,start
set colorcolumn=80
set encoding=utf-8
set expandtab
set foldmethod=indent
set hidden
set hlsearch incsearch
set ignorecase
set mouse=a
set nocompatible
set number
set shiftwidth=4
set smartcase
set splitright
set tabstop=4
set termguicolors
set ttimeoutlen=0
syntax enable
set background=dark
colorscheme OceanicNext

" undo
set undodir=~/.vim/undodir
set undofile
set undolevels=1000
set undoreload=10000

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


" ctrlp
if executable('rg')
    let g:ctrlp_user_command = 'rg --files %s'
    set grepprg=rg\ --vimgrep
    set grepformat^=%f:%l:%c:%m
endif
let g:ctrlp_use_caching = 0
let g:ctrlp_working_path_mode = 'w'
let g:ctrlp_custom_ignore = {
  \ 'dir': '\v[\/](htmlcov)',
  \ }
let g:elm_syntastic_show_warnings = 1
let g:elm_make_show_warnings = 1
let g:elm_format_autosave = 1

" LSP client
let g:lsc_server_commands = {
\   'elm': 'elm-language-server',
\   'python': {
\       'command': 'pyls',
\       'workspace_config': {
\           'pyls': {
\               'configurationSources': ['flake8'],
\               'plugins': {
\                   'yapf': { 'enabled': 0 }
\               }
\           }
\       },
\   },
\   'ocaml': 'ocamllsp',
\   'typescript': 'typescript-language-server --stdio',
\   'haskell': {
\       'command': 'haskell-language-server --lsp',
\       'suppress_stderr': v:true,
\   }
\ }
let g:lsc_auto_map = {
\   'defaults': v:true,
\   'ShowHover': 'gk',
\   'NextReference': 'cn',
\   'PreviousReference': 'cp',
\ }
nmap <silent> gd :LSClientWindowDiagnostics<CR>

" Ale
let g:ale_lint_on_text_changed = 1
let g:ale_set_baloons = 1
let g:ale_completion_enabled = 1
let g:ale_command_wrapper = 'nice -n5'
let g:ale_list_window_size = 5
let g:ale_fixers = {
\    '*': ['trim_whitespace'],
\    'yaml.ansible': ['ansible'],
\    'javascript': ['eslint'],
\    'typescript': ['eslint'],
\    'css': ['prettier'],
\    'python': ['black'],
\    'elm': ['elm-format'],
\    'haskell': ['stylish-haskell'],
\    'ocaml': ['ocamlformat', 'ocp-indent'],
\    'elixir': ['mix_format'],
\}
" disable most linters as they're covered by LSP
let g:ale_linters = {
\    'elm': [],
\    'elixir': ['elixir-ls'],
\    'python': ['mypy'],
\    'haskell': ['hlint'],
\    'ocaml': [],
\}
let g:ale_haskell_hlint_executable = 'stack'
let g:ale_haskell_stylish_haskell_executable = 'stack'
let g:ale_python_mypy_ignore_invalid_syntax = 1
let g:ale_elixir_elixir_ls_release = $HOME . '/lib/elixir-ls'
nmap <silent> <C-b> <Plug>(ale_fix)
nmap <silent> <leader>D <Plug>(ale_detail)
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)
nmap <silent> <leader>d :ALEGoToDefinition<CR>
nmap <silent> <leader>r :ALEFindReferences<CR>
nmap <silent> <leader>k <Plug>(ale_hover)

" vim-test
let g:test#runner_commands = ['PyTest']
let test#python#runner = 'pytest'
let test#go#runner = 'ginkgo'
let test#go#ginkgo#executable = 'ginkgo watch'
let test#go#ginkgo#options = '-skipMeasurements'
let test#strategy = 'vtr'
nmap <silent> <leader>t :TestNearest<CR>
nmap <silent> <leader>T :TestFile<CR>
nmap <silent> <leader>a :TestSuite<CR>
nmap <silent> <leader>g :TestVisit<CR>
nmap <silent> <leader>l :TestLast<CR>

" tmux
nnoremap <leader>va :VtrAttachToPane<cr>
nnoremap <leader>vs :VtrSendCommandToRunner<cr>
nnoremap <leader>vl :VtrSendLinesToRunner<cr>
nnoremap <leader>vo :VtrOpenRunner<cr>
nnoremap <leader>vk :VtrKillRunner<cr>
nnoremap <leader>vd :VtrDetachRunner<cr>
nnoremap <leader>vc :VtrClearRunner<cr>
nnoremap <leader>vf :VtrFlushCommand<cr>

" auto-complete
" disable preview scratch window
set completeopt=menu,menuone,preview,noinsert,noselect
set splitbelow
" limit popup menu height
set pumheight=15
let g:SuperTabDefaultCompletionType = 'context'

" Lang

" elm
" highlighting in elm code looks really bad
au FileType elm let g:ale_set_highlights = 0
let g:elm_setup_keybindings = 0

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

" ansible
let g:ansible_name_highlight = 'b'
let g:ansible_attribute_highlight = 'a'

" rust
let g:racer_cmd = '~/.cargo/bin/racer'
let g:rustfmt_autosave = 1

if filereadable(expand('~/.vimrc.local'))
  source ~/.vimrc.local
endif
