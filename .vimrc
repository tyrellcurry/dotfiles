"PLUG
call plug#begin()

" List your plugins here
Plug 'machakann/vim-highlightedyank'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'tpope/vim-sensible'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'morhetz/gruvbox'
call plug#end()

" Mouse support
set mouse=a
set ttymouse=sgr
set balloonevalterm
" Styled and colored underline support
let &t_AU = "\e[58:5:%dm"
let &t_8u = "\e[58:2:%lu:%lu:%lum"
let &t_Us = "\e[4:2m"
let &t_Cs = "\e[4:3m"
let &t_ds = "\e[4:4m"
let &t_Ds = "\e[4:5m"
let &t_Ce = "\e[4:0m"
" Strikethrough
let &t_Ts = "\e[9m"
let &t_Te = "\e[29m"
" Truecolor support
let &t_8f = "\e[38:2:%lu:%lu:%lum"
let &t_8b = "\e[48:2:%lu:%lu:%lum"
let &t_RF = "\e]10;?\e\\"
let &t_RB = "\e]11;?\e\\"
" Bracketed paste
let &t_BE = "\e[?2004h"
let &t_BD = "\e[?2004l"
let &t_PS = "\e[200~"
let &t_PE = "\e[201~"
" Cursor control
let &t_RC = "\e[?12$p"
let &t_SH = "\e[%d q"
let &t_RS = "\eP$q q\e\\"
let &t_SI = "\e[5 q"
let &t_SR = "\e[3 q"
let &t_EI = "\e[1 q"
let &t_VS = "\e[?12l"
" Focus tracking
let &t_fe = "\e[?1004h"
let &t_fd = "\e[?1004l"
execute "set <FocusGained>=\<Esc>[I"
execute "set <FocusLost>=\<Esc>[O"
" Window title
let &t_ST = "\e[22;2t"
let &t_RT = "\e[23;2t"

" vim hardcodes background color erase even if the terminfo file does
" not contain bce. This causes incorrect background rendering when
" using a color theme with a background color in terminals such as
" kitty that do not support background color erase.
let &t_ut=''

"Base config
set number
set relativenumber
set tabstop=4
set shiftwidth=4
set autoindent
set mouse=a
set hidden
" set shell=/bin/zsh
" Insert cursor single line
let &t_SI = "\e[6 q"
let &t_EI = "\e[2 q"
set ttimeout
set ttimeoutlen=1
set ttyfast
set belloff=all
"Syntax colors
syntax on
" Colorscheme
set t_Co=256
set background=dark
colo gruvbox" 
" Remap leader to space
nnoremap <SPACE> <Nop>
let mapleader=" "
" Highlight search
set hlsearch
set incsearch
" Casing for search
set ignorecase
set smartcase

" Clear highlighted search with Ctrl-C
nnoremap <C-c> :noh<CR>

" Explorer
nnoremap \ :CocCommand explorer --quit-on-open<CR>

" FZF
nnoremap <leader>sf :FZF<CR>
" Search for text across all files in the current directory
nnoremap <leader>sg :Rg<CR>
" Search for the word currently under the cursor
nnoremap <leader>sw :Rg <C-R><C-W><CR>
" Tell FZF to use Ripgrep for its file listing (ignores .gitignore)
let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --glob "!.git/*"'
" Make the FZF window look like a popup
let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6 } }

" set highlight to 1000 ms
let g:highlightedyank_highlight_duration = 150

" Use tab for trigger completion with characters ahead and navigate
" NOTE: There's always complete item selected by default, you may want to enable
" no select by `"suggest.noselect": true` in your configuration file
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

nmap <silent><nowait> [d <Plug>(coc-diagnostic-prev)
nmap <silent><nowait> ]d <Plug>(coc-diagnostic-next)

" GoTo code navigation
nmap <silent><nowait> gd <Plug>(coc-definition)
nmap <silent><nowait> gy <Plug>(coc-type-definition)
nmap <silent><nowait> gi <Plug>(coc-implementation)
nmap <silent><nowait> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code
xmap <leader>fc  <Plug>(coc-format-selected)
nmap <leader>fc  <Plug>(coc-format-selected)

" Format on save
" autocmd BufWritePre * call CocAction('format')

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s)
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
augroup end

" Applying code actions to the selected code block
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying refactor code actions
nmap <silent> <leader>re <Plug>(coc-codeaction-refactor)
xmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)
nmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)

" Run the Code Lens action on the current line
nmap <leader>cl  <Plug>(coc-codelens-action)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> to scroll float windows/popups
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Add `:Format` command to format current buffer
command! -nargs=0 Format :call CocActionAsync('format')

" Add `:Fold` command to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer
command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline
set statusline=%f\ %{coc#status()}%{get(b:,'coc_current_function','')}

" Show all diagnostics
nnoremap <silent><nowait> <space>x  :<C-u>CocDiagnostics<cr>

"Clang
set makeprg=clang-tidy\ %

" Store all swap files in a central location
set directory=~/.vim/swaps//
" Create the directory if it doesn't exist
if !isdirectory($HOME . "/.vim/swaps")
    call mkdir($HOME . "/.vim/swaps", "p", 0700)
endif
