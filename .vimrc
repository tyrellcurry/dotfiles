" ===========================================
" PLUGINS
" ===========================================
call plug#begin('~/.vim/plugged')
" Highlight yanked
Plug 'machakann/vim-highlightedyank'
" Gruvbox colorscheme
Plug 'morhetz/gruvbox'

" File management
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'preservim/nerdtree'

" Linting & Formatting
Plug 'dense-analysis/ale'

" Git integration
Plug 'tpope/vim-fugitive'

" Auto-pairs for brackets
Plug 'jiangmiao/auto-pairs'

call plug#end() 

" ===========================================
" BASE EDITOR SETTINGS
" ===========================================
" Display line numbers (absolute)
set number
" Display line numbers relative to current line
set relativenumber
" Number of spaces a <Tab> character displays as
set tabstop=4
" Number of spaces to use for each autoindent step
set shiftwidth=4
" Copy indent from current line when starting a new line
set autoindent
" Enable mouse support in all modes
set mouse=a
" Allow switching buffers without saving
set hidden
" Path for searching
set path+=**
" Enable wildmenu for command completion
set wildmenu

" ===========================================
" CURSOR APPEARANCE
" ===========================================
" Set cursor to vertical bar in insert mode
let &t_SI = "\e[6 q"
" Set cursor to block in normal mode
let &t_EI = "\e[2 q"
" Enable timeout for key codes
set ttimeout
" Time in ms to wait for a key code sequence (minimal delay)
set ttimeoutlen=1
" Indicates a fast terminal connection
set ttyfast
" Disable all bell sounds
set belloff=all

" ===========================================
" VISUAL SETTINGS
" ===========================================
" Enable syntax highlighting
syntax on
" Enable 256 color support
set t_Co=256
" Set dark background mode
set background=dark
" Set colorscheme to gruvbox
colo gruvbox
" set highlight to 150 ms
let g:highlightedyank_highlight_duration = 150

" ===========================================
" LEADER KEY
" ===========================================
" Disable default space behavior
nnoremap <SPACE> <Nop>
" Remap leader key to space
let mapleader=" "
" Set timeout for leader key sequences
set timeout
set timeoutlen=1000

" ===========================================
" SEARCH SETTINGS
" ===========================================
" Highlight all search matches
set hlsearch
" Show matches as you type
set incsearch
" Case-insensitive search by default
set ignorecase
" Override ignorecase if search contains uppercase
set smartcase
" Clear search highlighting with Ctrl-C
nnoremap <C-c> :noh<CR>

" ===========================================
" FZF SETTINGS
" ===========================================
" Fuzzy find files
nnoremap <Leader>sf :Files<CR>
" Switch between buffers
nnoremap <C-b> :Buffers<CR>
" Search file contents (requires ripgrep)
nnoremap <Leader>sg :Rg<CR>
" Search git files
nnoremap <Leader>gf :GFiles<CR>

" Use ripgrep for file finding (respects .gitignore)
let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --follow --glob "!.git/*"'

" Files command with preview window
command! -bang -nargs=? -complete=dir Files
    \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)

" Rg command with preview window
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview(), <bang>0)

" ===========================================
" NERDTREE SETTINGS
" ===========================================
" Toggle NERDTree
nnoremap <C-\> :NERDTreeToggle<CR>
" Find current file in NERDTree
nnoremap <C-f> :NERDTreeFind<CR>
" Show hidden files
let NERDTreeShowHidden=1
" Ignore certain files/folders
let NERDTreeIgnore=[
\   '\.git$[[dir]]',
\   'CMakeCache.txt$',
\   '\.cmake$'
\]
" Close vim if NERDTree is the only window left
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

" ===========================================
" ALE SETTINGS (LINTING)
" ===========================================
" Configure linters for C
let g:ale_linters = {
\   'c': ['gcc', 'cppcheck'],
\}

" Configure fixers for C
let g:ale_fixers = {
\   'c': ['clang-format'],
\}

" Auto-format on save
let g:ale_fix_on_save = 1

" Use compile_commands.json if it exists
let g:ale_c_parse_compile_commands = 1

" Lint only on save (not while typing)
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_insert_leave = 0
let g:ale_lint_on_save = 1

" Custom compiler flags
let g:ale_c_gcc_options = '-Wall -Wextra -Wpedantic -std=c99 -I./include'
let g:ale_c_cppcheck_options = '--enable=warning,style,performance,portability'

" Error navigation
nmap <silent> [d <Plug>(ale_previous_wrap)
nmap <silent> ]d <Plug>(ale_next_wrap)

" Show error details
nmap <silent> <Leader>x :ALEDetail<CR>

" ===========================================
" VIM-FUGITIVE SETTINGS
" ===========================================
" Git status
nnoremap <Leader>gs :Git<CR>
" Git commit
nnoremap <Leader>gc :Git commit<CR>
" Git push
nnoremap <Leader>gp :Git push<CR>
" Git pull
nnoremap <Leader>gl :Git pull<CR>
" Git diff
nnoremap <Leader>gd :Gdiffsplit<CR>
" Git blame
nnoremap <Leader>gb :Git blame<CR>
" Git log
nnoremap <Leader>glog :Git log<CR>

" ===========================================
" FUNCTIONS
" ===========================================
" Store all swap files in a central location
set directory=~/.vim/swaps//
" Create the directory if it doesn't exist
if !isdirectory($HOME . "/.vim/swaps")
    call mkdir($HOME . "/.vim/swaps", "p", 0700)
endif

" ===========================================
" CUSTOM
" ===========================================
" Open terminal
nnoremap <leader>tr :set splitright \| vertical term<CR>

function! OscCopy()
  let encodedText=@"
  let encodedText=substitute(encodedText, '\', '\\\\', "g")
  let encodedText=substitute(encodedText, "'", "'\\\\'", "g")
  let executeCmd="echo -n '".encodedText."' | base64 | tr -d '\\n'"
  let encodedText=system(executeCmd)
  if $TMUX != ""
    "tmux
    let executeCmd='echo -en "\x1bPtmux;\x1b\x1b]52;;'.encodedText.'\x1b\x1b\\\\\x1b\\" > /dev/tty'
  else
    let executeCmd='echo -en "\x1b]52;;'.encodedText.'\x1b\\" > /dev/tty'
  endif
  call system(executeCmd)
  redraw!
endfunction
nnoremap <leader>y :call OscCopy()<CR>
