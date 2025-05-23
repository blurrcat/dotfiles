call plug#begin('~/.vim/plugged')

" IDE
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'airblade/vim-gitgutter'
Plug 'altercation/vim-colors-solarized'
Plug 'ctrlpvim/ctrlp.vim'
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
Plug 'tpope/vim-surround'
Plug 'tpope/vim-sleuth'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'w0rp/ale'
Plug 'christoomey/vim-tmux-runner'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

" language packs
Plug 'Glench/Vim-Jinja2-Syntax'
Plug 'andys8/vim-elm-syntax'
Plug 'elixir-editors/vim-elixir'
Plug 'leafgarland/typescript-vim'
Plug 'mattn/emmet-vim'
Plug 'mxw/vim-jsx'
Plug 'wavded/vim-stylus'
Plug 'georgewitteman/vim-fish'
Plug 'hhvm/vim-hack'
Plug 'pearofducks/ansible-vim'


call plug#end()

set backupcopy=yes
set colorcolumn=80
set expandtab
set foldmethod=indent
set mouse=a
set number
set ignorecase
set smartcase
set splitright
set termguicolors
set completeopt=menu,menuone,noinsert,noselect
set pumheight=15
colorscheme OceanicNext

" {{{ airline
let g:airline_theme='oceanicnext'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline#extensions#tabline#buffer_idx_mode = 1
let g:airline#extensions#tabline#buffer_nr_show = 0
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
let g:airline#extensions#ale#enabled = 1
let g:airline_symbols_ascii = 1
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
" }}}

" {{{ nerdtree
map <C-n> :NERDTreeToggle<CR>
let NERDTreeRespectWildIgnore=1
let NERDTreeWinSize = 30
let NERDTreeQuitOnOpen = 1
let NERDTreeAutoDeleteBuffer = 1
" }}}


" {{{ ctrlp
if executable('rg')
    let g:ctrlp_user_command = 'rg --files %s'
    set grepprg=rg\ --vimgrep
    set grepformat^=%f:%l:%c:%m
    " search word under cursor
    nnoremap <leader>f :Rg <cword><cr>
endif
let g:ctrlp_use_caching = 0
let g:ctrlp_working_path_mode = 'w'
let g:ctrlp_custom_ignore = {
  \ 'dir': '\v[\/](htmlcov)',
  \ }
" }}}

" {{{ LSP client
let g:lsc_server_commands = {
\   'elm': 'elm-language-server',
\   'python': {
\       'command': 'pyls --log-file /dev/null',
\       'workspace_config': {
\           'pyls': {
\               'configurationSources': ['flake8'],
\           },
\       }
\   },
\   'ocaml': 'ocamllsp',
\   'typescript': 'typescript-language-server --stdio',
\   'haskell': {
\       'command': 'haskell-language-server-wrapper --lsp',
\   },
\   'hack': 'hh_client lsp --from vim'
\ }
let g:lsc_auto_map = {
\   'defaults': v:true,
\   'NextReference': 'cn',
\   'PreviousReference': 'cp',
\ }
nmap <silent> gd :LSClientWindowDiagnostics<CR>
nmap <silent> ge :LSClientLineDiagnostics<CR>
" }}}

" {{{ ale
let g:ale_lint_on_text_changed = 1
let g:ale_set_baloons = 1
let g:ale_completion_enabled = 1
let g:ale_command_wrapper = 'nice -n5'
let g:ale_list_window_size = 5
let g:ale_fixers = {
\    '*': ['trim_whitespace'],
\    'javascript': ['eslint'],
\    'typescript': ['eslint'],
\    'css': ['prettier'],
\    'elm': ['elm-format'],
\    'python': ['black'],
\    'haskell': ['hlint', 'ormolu'],
\    'ocaml': ['ocamlformat', 'ocp-indent'],
\    'elixir': ['mix_format'],
\}
" disable most linters as they're covered by LSP
let g:ale_linters = {
\    'elixir': ['elixir-ls'],
\    'python': ['mypy'],
\    'haskell': [],
\    'ocaml': [],
\    'hack': []
\}
let g:ale_haskell_hlint_executable = 'stack'
let g:ale_haskell_ormolu_executable = 'stack'
let g:ale_python_mypy_ignore_invalid_syntax = 1
let g:ale_elixir_elixir_ls_release = $HOME . '/lib/elixir-ls'
nmap <silent> <C-b> <Plug>(ale_fix)
nmap <silent> <leader>D <Plug>(ale_detail)
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)
nmap <silent> <leader>d :ALEGoToDefinition<CR>
nmap <silent> <leader>r :ALEFindReferences<CR>
nmap <silent> <leader>k <Plug>(ale_hover)
" end ale }}}

" {{{ vim-test
let g:test#runner_commands = ['PyTest']
let test#python#runner = 'pytest'
let g:test#python#pytest#file_pattern = '\v.*.py$'
let test#strategy = 'vtr'
nmap <silent> <leader>t :TestNearest<CR>
nmap <silent> <leader>T :TestFile<CR>
nmap <silent> <leader>a :TestSuite<CR>
nmap <silent> <leader>l :VtrSendCommandToRunner<CR>
" }}}

" {{{ tmux
let g:VtrOrientation = "h"
let g:VtrPercentage = 35
nnoremap <leader>va :VtrAttachToPane<cr>
nnoremap <leader>vs :VtrSendCommandToRunner<cr>
nnoremap <leader>vl :VtrSendLinesToRunner<cr>
nnoremap <leader>vo :VtrOpenRunner<cr>
nnoremap <leader>vk :VtrKillRunner<cr>
nnoremap <leader>vd :VtrDetachRunner<cr>
nnoremap <leader>vc :VtrClearRunner<cr>
nnoremap <leader>vf :VtrFlushCommand<cr>
" automatically attach to pane 1
autocmd VimEnter * :silent! :VtrAttachToPane 1<cr>
" }}}

" {{{ supertab
let g:SuperTabDefaultCompletionType = "<c-n>"
let g:SuperTabContextDefaultCompletionType = "<c-n>"
" }}}

" Lang

" {{{ elm
" highlighting in elm code looks really bad
au FileType elm let g:ale_set_highlights = 0
let g:elm_setup_keybindings = 0
let g:elm_syntastic_show_warnings = 1
let g:elm_make_show_warnings = 1
let g:elm_format_autosave = 1
" }}}

" {{{ emmet
let g:user_emmet_settings = {
\  'javascript.jsx' : {
\      'extends' : 'jsx',
\  },
\  'javascript' : {
\      'extends' : 'jsx',
\  },
\}
let g:user_emmet_mode = 'a'
" }}}

" {{{ rust
let g:racer_cmd = '~/.cargo/bin/racer'
let g:rustfmt_autosave = 1
" }}}

" {{{ text
fun! SpellCheck()
    setlocal spell
    syntax match UrlNoSpell '\w\+:\/\/[^[:space:]]\+' contains=@NoSpell
    syntax match AcronymNoSpell '\<\(\u\|\d\)\{3,}s\?\>' contains=@NoSpell
endfun
autocmd FileType markdown,text :call SpellCheck()
" }}}

if filereadable(expand('~/.vimrc.local'))
  source ~/.vimrc.local
endif
