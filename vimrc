"Load my bundles
source ~/dotfiles-pierrot/vimrc-plugins

" THEME
syntax on
set noshowmode
set noswapfile

let g:airline_powerline_fonts = 1
let g:airline_theme='base16_brewer'
" should not be useful on neovim (always display status bar)
set laststatus=2

set t_Co=256

""""""""" THEME """"""""""
colorscheme base16-bright
if has("termguicolors")
  set termguicolors
endif

" fix bad Search Highlight color (making text not readable)
hi Search guibg=peru guifg=wheat
""""""""""""""""""""""""""

" Display the filename in the status bar
" set statusline+=%F

" Leader is Space
let mapleader = "\<Space>"
nmap <F8> :source $HOME/.vimrc<ENTER>

" Leader for nvimux
let g:nvimuxqprefix='<C-Space>'
let nvimux_open_term_by_default=1 " Open a term <prefix>-c

" manage split size
nmap <C-W>H :vertical resize +5<cr>
nmap <C-W>L :vertical resize -5<cr>
nmap <C-W>K :resize -5<cr>
nmap <C-W>J :resize +5<cr>

" avoid escape but can break Vim 8 (not nvim)
inoremap jj <Esc>
inoremap jk <Esc>
imap <Esc> <Nop>

" implicite :%s/old/new/g for :%s/old/new/
set gdefault

" No more up/down arrows in command mode
cnoremap <C-k> <Up>
cnoremap <C-j> <Down>

" Navigate between grep results with ]q and [q
nmap ]q :cnext<cr>
nmap [q :cprev<cr>
nmap ]Q :clast<cr>
nmap [Q :cfirst<cr>

" Create a file with <space>gf
map <leader>gf :e <cfile><cr>

" Clear the seach with Space /
nnoremap <Leader>/ :noh<cr>

set number              " Display lines number
set relativenumber      " Display lines relatively to the current line
set cursorline          " Highlight the current line
set hidden              " Hidden buffer

set autoindent          " copy indent from current line when starting a new line
set smartindent         " insert new line at the last know indentation
set expandtab           " use the appropriate number of spaces to insert a tab
set noswapfile          " because it's anoying
set tabstop=2           " number of spaces that a <Tab> in the file counts for
set shiftwidth=2        " number of spaces to use for each step of (auto)indent

set ruler               " show the current line and column number
set hlsearch            " highlight searches
set incsearch           " do incremental searching
set showmatch           " jump to matches when entering regexp
set ignorecase          " ignore case when searching
set smartcase           " no ignorecase if Uppercase char present

set inccommand=nosplit  "Shows the effects of a command incrementally, as you type.

set showcmd             " display incomplete commands (ex: type z, it appears at the bottom right)
set nobackup            " do not keep a backup file

set autoread            " change outside of Vim: automatically read it again.
set scrolloff=10         " scroll the page before the end of the window

" ####### PLUGINS
" avoid jshint to be selected by ALE to lint
let g:ale_linters = {
\   'javascript': ['eslint'],
\   'typescript': ['tslint']
\}
let g:ale_linter_aliases = {'less': 'css'}

" navigate between linter errors
nmap ]l :ALENext<CR>
nmap [l :ALEPrevious<CR>

" avoid linting on text change (CPUing too much !)
let g:ale_lint_on_text_changed = 'never'

nmap <silent> <leader>T :TestFile<CR>

" get in the current directory (local to the buffer with lcd)
map <leader>cd :lcd %:h<CR>

nmap <C-p> :FZF<CR>

" Leave terminal mode with escape
tnoremap <Esc> <C-\><C-n>

" Move like jagger when I'm in a terminal
tnoremap <C-w>h <C-\><C-n><C-w>h
tnoremap <C-w>j <C-\><C-n><C-w>j
tnoremap <C-w>k <C-\><C-n><C-w>k
tnoremap <C-w>l <C-\><C-n><C-w>l

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" OpenChangedFiles COMMAND
" Open a split for each dirty file in git
"
" Shamelessly stolen from Gary Bernhardt: https://github.com/garybernhardt/dotfiles
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! OpenChangedFiles()
  only " Close all windows, unless they're modified
  let status = system('git status -s | grep "^ \?\(M\|A\|UU\)" | sed "s/^.\{3\}//"')
  let filenames = split(status, "\n")
  exec "edit " . filenames[0]
  for filename in filenames[1:]
    exec "sp " . filename
  endfor
endfunction
command! OpenChangedFiles :call OpenChangedFiles()

" base16-bright
" theses lines should be the exact same 15 colors of the
" terminal configuration (gnome-terminal/mate-terminal)
let g:terminal_color_0 = "#000000"
let g:terminal_color_1 = "#fb0120"
let g:terminal_color_2 = "#a1c659"
let g:terminal_color_3 = "#fda331"
let g:terminal_color_4 = "#6fb3d2"
let g:terminal_color_5 = "#d381c3"
let g:terminal_color_6 = "#76c7b7"
let g:terminal_color_7 = "#e0e0e0"
let g:terminal_color_8 = "#b0b0b0"
let g:terminal_color_9 = "#fb0120"
let g:terminal_color_10 = "#a1c659"
let g:terminal_color_11 = "#fda331"
let g:terminal_color_12 = "#6fb3d2"
let g:terminal_color_13 = "#d381c3"
let g:terminal_color_14 = "#76c7b7"
let g:terminal_color_15 = "#ffffff"
