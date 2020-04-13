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
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-unimpaired'


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
Plug 'nanotech/jellybeans.vim', { 'tag': 'v1.7' }
Plug 'kassio/neoterm'
" Plug 'tomasr/molokai'
" Plug 'chriskempson/base16-vim'

" Plug 'rizzatti/dash.vim'
" Plug 'Shougo/deoplete.nvim', { 'do': function('DoRemote') }
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

Plug 'jwilm/i3-vim-focus'

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

Plug 'neoclide/coc.nvim', {'branch': 'release'}
 Plug 'elixir-lsp/elixir-ls', { 'do': { -> g:ElixirLS.compile() } }

call plug#end()


let g:polyglot_disabled = ['go']
" let g:deoplete#enable_at_startup = 1
" let g:deoplete#disable_auto_complete = 0
" call deoplete#custom#option('omni_patterns', { 'go': '[^. *\t]\.\w*' })

let g:python_host_prog = $HOME . '/.asdf/installs/python/2.7.15/bin/python'
let g:python3_host_prog = $HOME . '/.asdf/installs/python/3.6.8/bin/python3'

let g:go_addtags_transform = "snakecase"
let g:go_version_warning = 0
let g:go_fmt_command = "gofmt"
let g:go_auto_type_info = 1
let g:go_auto_sameids = 1
let g:go_def_mapping_enabled = 0
" #let g:go_build_tags = prod"

let g:coc_global_extensions = ['coc-elixir', 'coc-diagnostic']
let g:ElixirLS = {}
let ElixirLS.path = stdpath('config').'/plugged/elixir-ls'
let ElixirLS.lsp = ElixirLS.path.'/release/language_server.sh'
let ElixirLS.cmd = join([
        \ 'asdf install &&',
        \ 'mix do',
        \ 'local.hex --force --if-missing,',
        \ 'local.rebar --force,',
        \ 'deps.get,',
        \ 'compile,',
        \ 'elixir_ls.release'
        \ ], ' ')


function ElixirLS.on_stdout(_job_id, data, _event)
  let self.output[-1] .= a:data[0]
  call extend(self.output, a:data[1:])
endfunction

let ElixirLS.on_stderr = function(ElixirLS.on_stdout)

function ElixirLS.on_exit(_job_id, exitcode, _event)
  if a:exitcode[0] == 0
    echom '>>> ElixirLS compiled'
  else
    echoerr join(self.output, ' ')
    echoerr '>>> ElixirLS compilation failed'
  endif
endfunction

function ElixirLS.compile()
  let me = copy(g:ElixirLS)
  let me.output = ['']
  echom '>>> compiling ElixirLS'
  let me.id = jobstart('cd ' . me.path . ' && git pull && ' . me.cmd, me)
endfunction

" Then, update the Elixir language server
call coc#config('elixir', {
  \ 'command': g:ElixirLS.lsp,
  \ 'filetypes': ['elixir', 'eelixir']
  \})
call coc#config('elixir.pathToElixirLS', g:ElixirLS.lsp)

augroup NeoformatAutoFormat
  autocmd!
  autocmd BufWritePre *.{js,jsx,css,scss,ex,exs,rb,rabl,rake,html,json,yaml,erb,rb,rs} Neoformat
augroup END

" explicit TAB for deoplete
"function! s:check_back_space() abort "{{{
"  let col = col('.') - 1
"  return !col || getline('.')[col - 1]  =~ '\s'
"endfunction"}}}

""use TAB as the mapping
"inoremap <silent><expr> <TAB>
"      \ pumvisible() ? "\<C-n>" :
     " \ <SID>check_back_space() ? "\<TAB>" :
" \ deoplete#manual_complete()
" inoremap <silent><expr><S-TAB>  pumvisible() ? "\<C-p>" : "\<TAB>"
" inoremap <expr><BS>  deoplete#smart_close_popup()."\<C-h>"


" Required:
filetype plugin indent on


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
"   aut/cmd! BufWritePost * Neomake
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
set titlestring=%F\ NVIM

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
nnoremap <leader>aj :ALENext<cr>
nnoremap <silent> <leader>ak :ALEPrevious<cr>

nnoremap <Leader>b :ls<CR>:b<Space>
nnoremap <leader>c :!cargo clippy

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

" turn to next or previous errors, after open location list
nmap <leader>j :lnext<CR>
nmap <leader>k :lprevious<CR>

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

"  i3 vim focus
map gwl :call Focus('right', 'l')<CR>
map gwh :call Focus('left', 'h')<CR>
map gwk :call Focus('up', 'k')<CR>
map gwj :call Focus('down', 'j')<CR>

" coc.nvim
"
" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
"if exists('*complete_info')
"  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
"else
"  imap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
"endif

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current line.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Introduce function text object
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <TAB> for selections ranges.
" NOTE: Requires 'textDocument/selectionRange' support from the language server.
" coc-tsserver, coc-python are the examples of servers that support it.
nmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <TAB> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings using CoCList:
" Show all diagnostics.
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>
