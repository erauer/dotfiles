function! DoRemote(arg)
  UpdateRemotePlugins
endfunction

if has('vim_starting')
  set nocompatible               " Be iMproved
endif

let vimplug_exists=expand('~/.config/nvim/autoload/plug.vim')

if !filereadable(vimplug_exists)
  if !executable("curl")
    echoerr "You have to install curl or first install vim-plug yourself!"
    execute "q!"
  endif
  echo "Installing Vim-Plug..."
  echo ""
  silent !\curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  let g:not_finish_vimplug = "yes"

  autocmd VimEnter * PlugInstall
endif

" Required:
call plug#begin(expand('~/.config/nvim/plugged'))

"*****************************************************************************
"" Plug install packages
"*****************************************************************************
" Plug 'scrooloose/nerdtree'
" Plug 'jistr/vim-nerdtree-tabs'
" Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-vinegar'


Plug 'sbdchd/neoformat'
" Plug 'benekastah/neomake'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'airblade/vim-gitgutter'

"" Vim-Session
Plug 'xolox/vim-misc'
Plug 'xolox/vim-session'

Plug 'honza/vim-snippets'

"" Color
Plug 'mhartington/oceanic-next'
Plug 'gh123man/vim-atom-dark-modded-256'
Plug 'nanotech/jellybeans.vim', { 'tag': 'v1.6' }
Plug 'kassio/neoterm'
" Plug 'tomasr/molokai'
" Plug 'chriskempson/base16-vim'

" Plug 'rizzatti/dash.vim'
Plug 'Shougo/deoplete.nvim', { 'do': function('DoRemote') }
" Plug 'zchee/deoplete-go', { 'do': 'make'}
"
Plug 'w0rp/ale'

Plug 'rking/ag.vim'
Plug 'jaawerth/nrun.vim'

Plug 'mhartington/nvim-typescript'

Plug 'lambdalisue/suda.vim'

" Fzf
Plug '/usr/bin/fzf'
Plug 'junegunn/fzf.vim'

"*****************************************************************************
"" Custom bundles
"*****************************************************************************

" elixir
Plug 'elixir-lang/vim-elixir'
Plug 'carlosgaldino/elixir-snippets'
Plug 'slashmili/alchemist.vim'
Plug 'powerman/vim-plugin-AnsiEsc'


" erlang
Plug 'jimenezrick/vimerl'


" html
"" HTML Bundle
Plug 'hail2u/vim-css3-syntax'
Plug 'gorodinskiy/vim-coloresque'
Plug 'tpope/vim-haml'
Plug 'mattn/emmet-vim'

" PlantUML

Plug 'scrooloose/vim-slumlord'

" javascript
"" Javascript Bundle
Plug 'jelera/vim-javascript-syntax'

" Go
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

Plug 'sheerun/vim-polyglot'
call plug#end()

let g:polyglot_disabled = ['go']
let g:deoplete#enable_at_startup = 1
let g:deoplete#disable_auto_complete = 0
call deoplete#custom#option('omni_patterns', { 'go': '[^. *\t]\.\w*' })

let g:python_host_prog = $HOME . '/.asdf/installs/python/2.7.15/bin/python'
let g:python3_host_prog = $HOME . '/.asdf/installs/python/3.6.8/bin/python3'

let g:go_addtags_transform = "snakecase"
let g:go_version_warning = 0
let g:go_fmt_command = "gofmt"
let g:go_auto_type_info = 0
let g:go_build_tags = "prod"


augroup NeoformatAutoFormat
  autocmd!
  autocmd BufWritePre *.{js,jsx,css,scss,ex,exs,rb,rabl,rake,html,json,yaml,erb,rb} Neoformat
augroup END

" explicit TAB for deoplete
function! s:check_back_space() abort "{{{
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction"}}}

""use TAB as the mapping
inoremap <silent><expr> <TAB>
      \ pumvisible() ?  "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ deoplete#mappings#manual_complete()

inoremap <silent><expr><S-TAB>  pumvisible() ? "\<C-p>" : "\<TAB>"
inoremap <expr><BS>  deoplete#smart_close_popup()."\<C-h>"


" Required:
filetype plugin indent on

" Let <Tab> also do completion
inoremap <silent><expr> <S-Tab>
\ pumvisible() ? "\<C-n>" :
\ deoplete#mappings#manual_complete()


"*****************************************************************************
"" Basic Setup
"*****************************************************************************"
"" Encoding
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8
set bomb
set binary


"" Fix backspace indent
set backspace=indent,eol,start

"" Tabs. May be overriten by autocmd rules
set tabstop=2
set softtabstop=0
set shiftwidth=2
set expandtab

"" Map leader to ,
let g:mapleader=','

"" Enable hidden buffers
set hidden

"" Searching
set hlsearch
set incsearch
set ignorecase
set smartcase

" Stop highlighting on Enter
" map <CR> :noh<CR>

"" Directories for swp files
set nobackup
set noswapfile

set fileformats=unix,dos,mac
set showcmd
set inccommand=nosplit

if exists('$SHELL')
    set shell=$SHELL
else
    set shell=/bin/sh
endif

set clipboard=unnamedplus
" session management
let g:session_directory = "~/.config/nvim/session"
let g:session_autoload = "no"
let g:session_autosave = "no"
let g:session_command_aliases = 1

"*****************************************************************************
"" Visual Settings
"*****************************************************************************
syntax on
set ruler
set number

let no_buffers_menu=1
if !exists('g:not_finish_vimplug')
  if (has("termguicolors"))
    set termguicolors
  endif

  " Theme
  syntax enable

  set background=dark
  colorscheme jellybeans
endif


"" Disable the blinking cursor.
set gcr=a:blinkon0
set scrolloff=3

" highlight cursor position
set cursorline
" set cursorcolumn

" change cursor to bar in insert mode
let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1

" run tests with :T
let test#strategy = "neoterm"

" pretty much essential: by default in terminal mode, you have to press ctrl-\-n to get into normal mode
" ain't nobody got time for that
tnoremap <Esc> <C-\><C-n>

" Run Neomake when I save any buffer
" augroup localneomake
"   autocmd! BufWritePost * Neomake
" augroup END

" let g:neomake_javascript_enabled_makers = ['eslint']
" let g:neomake_typescript_enabled_makers = ['tslint']
" when switching/opening a JS buffer, set neomake's eslint path, and enable it as a maker
" au BufEnter *.js let b:neomake_javascript_eslint_exe = nrun#Which('eslint')
" au BufEnter *.ts let b:neomake_typescript_tslint_exe = nrun#Which('tslint')
" au BufWinEnter,BufWritePost * Neomake

" let g:neomake_elixir_enabled_makers = ['mix', 'credo']

" Neoterm

" let g:neoterm_position = 'vertical'
let g:neoterm_automap_keys = ',tt'

" Useful maps
" hide/close terminal
nnoremap <silent> ,th :call neoterm#close()<cr>
" clear terminal
nnoremap <silent> ,tl :call neoterm#clear()<cr>
" kills the current job (send a <c-c>)
nnoremap <silent> ,tc :call neoterm#kill()<cr>


" Sane tabs
" - Two spaces wide
set tabstop=2
set softtabstop=2
" - Expand them all
set expandtab
" - Indent by 2 spaces by default
set shiftwidth=2

set number " line numbering

set encoding=utf-8


" Check syntax with neomake when writing file
" autocmd! BufWritePost * Neomake
"" Status bar

" Don't tell me to use smartquotes in markdown ok?
" let g:neomake_markdown_enabled_makers = []


set laststatus=2

"" Use modeline overrides
set modeline
set modelines=10

" Set the title of the iterm tab
set title
set titleold="Terminal"
set titlestring=%F

set statusline=%F%m%r%h%w%=(%{&ff}/%Y)\ (line\ %l\/%L,\ col\ %c)\

if exists("*fugitive#statusline")
  set statusline+=%{fugitive#statusline()}
endif

" vim-airline
let g:airline_theme='oceanicnext'
let g:airline#extensions#syntastic#enabled = 1
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tagbar#enabled = 1
let g:airline_skip_empty_sections = 1

"" NERDTree configuration
" let g:NERDTreeChDirMode=2
" let g:NERDTreeIgnore=['\.rbc$', '\~$', '\.pyc$', '\.db$', '\.sqlite$', '__pycache__','\.git']
" let g:NERDTreeSortOrder=['^__\.py$', '\/$', '*', '\.swp$', '\.bak$', '\~$']
" let g:NERDTreeShowBookmarks=1
" let g:nerdtree_tabs_focus_on_files=1
" let g:NERDTreeWinSize = 50
" Git marker for nerdtree
" let g:NERDTreeShowIgnoredStatus=0
" let g:NERDTreeShowHidden=1

set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.pyc,*.db,*.sqlite
" map <C-n> :NERDTreeToggle<CR>
" Quit NERDTree if last buffer closed
" autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

"*****************************************************************************
"" Functions
"*****************************************************************************
if !exists('*s:setupWrapping')
  function s:setupWrapping()
    set wrap
    set wm=2
    set textwidth=79
  endfunction
endif

"*****************************************************************************
"" Autocmd Rules
"*****************************************************************************
"" The PC is fast enough, do syntax highlight syncing from start unless 200 lines
augroup vimrc-sync-fromstart
  autocmd!
  autocmd BufEnter * :syntax sync maxlines=200
augroup END

"" Remember cursor position
augroup vimrc-remember-cursor-position
  autocmd!
  autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
augroup END

"" txt
augroup vimrc-wrapping
  autocmd!
  autocmd BufRead,BufNewFile *.txt call s:setupWrapping()
augroup END

"" make/cmake
augroup vimrc-make-cmake
  autocmd!
  autocmd FileType make setlocal noexpandtab
  autocmd BufNewFile,BufRead CMakeLists.txt setlocal filetype=cmake
augroup END

set autoread

"*****************************************************************************
"" Mappings
"*****************************************************************************

noremap <Leader>te :tabe <C-R>=expand("%:p:h") . "/" <CR>
nnoremap - :Explore<CR>
" nnoremap <Leader>f :Explore <C-r>=getcwd()<CR><CR>
nnoremap <Leader>f :Explore .<CR>


" snippets
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<c-b>"
let g:UltiSnipsEditSplit="vertical"

" syntastic
let g:syntastic_always_populate_loc_list=1
let g:syntastic_error_symbol='✗'
let g:syntastic_warning_symbol='⚠'
let g:syntastic_style_error_symbol = '✗'
let g:syntastic_style_warning_symbol = '⚠'
let g:syntastic_auto_loc_list=1
let g:syntastic_aggregate_errors = 1
let g:syntastic_typescript_checkers = ['tslint']

" Disable mouse click to go to position
set mouse-=a

" Tagbar
nmap <silent> <F4> :TagbarToggle<CR>
let g:tagbar_autofocus = 1

" netrw
let g:netrw_liststyle = 3
autocmd FileType netrw setl bufhidden=delete


" Disable visualbell
set noerrorbells visualbell t_vb=
if has('autocmd')
  autocmd GUIEnter * set visualbell t_vb=
endif


if has('macunix')
  " pbcopy for OSX copy/paste
  vmap <C-x> :!pbcopy<CR>
  vmap <C-c> :w !pbcopy<CR><CR>
endif


"" Close buffer
noremap <leader>c :bd<CR>

"" Switching windows
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l
noremap <C-h> <C-w>h

"" Vmap for maintain Visual Mode after shifting > and <
vmap < <gv
vmap > >gv

"" Open current line on GitHub
nnoremap <Leader>o :.Gbrowse<CR>

" NERDTree shortcuts
" nnoremap <C-p> :NERDTreeToggle<CR>
"
nnoremap <C-p> :Files<Cr>

"*****************************************************************************
"" Custom configs
"*****************************************************************************


" set foldmethod=indent

" elixir


" erlang
let erlang_folding = 1
let erlang_show_errors = 1

let g:alchemist_iex_term_split = 'split'
let g:alchemist#extended_autocomplete = 1

"optional if you want to close the preview window automatically
autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
autocmd InsertLeave * if pumvisible() == 0|pclose|endif

" html
" for html files, 2 spaces
autocmd Filetype html setlocal ts=2 sw=2 sts=2 expandtab

" golang
autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=4 shiftwidth=4

" javascript
let g:javascript_enable_domhtmlcss = 1

" vim-javascript
augroup vimrc-javascript
  autocmd!
  autocmd BufWritePre * %s/\s\+$//e
  autocmd FileType javascript setlocal ts=2 sw=2 sts=2 expandtab
augroup END


set diffopt=vertical,filler
autocmd FileType git set nofoldenable

"*****************************************************************************
"*****************************************************************************

"" Include user's local vim config
if filereadable(expand("~/.config/nvim/local_init.vim"))
  source ~/.config/nvim/local_init.vim
endif

"*****************************************************************************
"" Convenience variables
"*****************************************************************************

" vim-airline
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

" search
set hlsearch
set incsearch
set ignorecase


if !exists('g:airline_powerline_fonts')
  let g:airline#extensions#tabline#left_sep = ' '
  let g:airline#extensions#tabline#left_alt_sep = '|'
  let g:airline_left_sep          = '▶'
  let g:airline_left_alt_sep      = '»'
  let g:airline_right_sep         = '◀'
  let g:airline_right_alt_sep     = '«'
  let g:airline#extensions#branch#prefix     = '⤴' "➔, ➥, ⎇
  let g:airline#extensions#readonly#symbol   = '⊘'
  let g:airline#extensions#linecolumn#prefix = '¶'
  let g:airline#extensions#paste#symbol      = 'ρ'
  let g:airline_symbols.linenr    = '␊'
  let g:airline_symbols.branch    = '⎇'
  let g:airline_symbols.paste     = 'ρ'
  let g:airline_symbols.paste     = 'Þ'
  let g:airline_symbols.paste     = '∥'
  let g:airline_symbols.whitespace = 'Ξ'
else
  let g:airline#extensions#tabline#left_sep = ''
  let g:airline#extensions#tabline#left_alt_sep = ''

  " powerline symbols
  let g:airline_left_sep = ''
  let g:airline_left_alt_sep = ''
  let g:airline_right_sep = ''
  let g:airline_right_alt_sep = ''
  let g:airline_symbols.branch = ''
  let g:airline_symbols.readonly = ''
  let g:airline_symbols.linenr = ''
endif
