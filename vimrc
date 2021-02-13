"Load my bundles
source ~/dotfiles-pierrot/vimrc-plugins

" THEME
syntax on
set noshowmode
set noswapfile

" Asked by Vial-http
set hidden
filetype plugin on

let g:airline_powerline_fonts = 1

set t_Co=256

" Default shell for neovim
set shell=/usr/bin/zsh

""""""""" THEME """"""""""
if (has("nvim"))
  "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif

colorscheme palenight

" I need to override ctermbg because of a gray background on kitty
highlight Normal ctermbg=None

let g:airline_theme = "palenight"

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
set hidden              " Keep new file in buffer

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
set scrolloff=10        " scroll the page before the end of the window

set guicursor=          " Fix cursor invisible behavior

" ####### PLUGINS
" save code annotations from vim-bookmarks
let g:bookmark_auto_save = 1
let g:bookmark_no_default_key_mappings = 1
nmap <Leader><Leader> <Plug>BookmarkToggle
nmap <Leader>i <Plug>BookmarkAnnotate
nmap <Leader>a <Plug>BookmarkShowAll
nmap <Leader>n <Plug>BookmarkNext
nmap <Leader>p <Plug>BookmarkPrev
nmap <Leader>c <Plug>BookmarkClear
nmap <Leader>x <Plug>BookmarkClearAll
nmap <Leader>kk <Plug>BookmarkMoveUp
nmap <Leader>jj <Plug>BookmarkMoveDown
nmap <Leader>g <Plug>BookmarkMoveToLine

" correct updatetime for gitgutter (avoid laggy things)
set updatetime=1000

" get in the current directory (local to the buffer with lcd)
map <leader>cd :lcd %:h<CR>

nmap <C-p> :FZF<CR>

" Leave terminal mode with escape
tnoremap <Esc> <C-\><C-n>

" Automatically enter insert mode in a terminal
autocmd TermOpen * startinsert

" Move like jagger when I'm in a terminal
tnoremap <C-w>h <C-\><C-n><C-w>h
tnoremap <C-w>j <C-\><C-n><C-w>j
tnoremap <C-w>k <C-\><C-n><C-w>k
tnoremap <C-w>l <C-\><C-n><C-w>l

" Open correctly files inside a terminal session
if has('nvim')
  let $VISUAL = 'nvr -cc split --remote-wait'
endif

" Prettier
nmap <leader>p :Prettier<CR>

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

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""""""  **CUSTOMS**  """"""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Ggrep the word under cursor (in a new split)
nmap <F3> "zyiw:vsplit<CR><C-w>l:exe "Ggrep ".@z.""<CR>

" Ranger replace netrw
let g:ranger_replace_netrw = 1

" Need this to parse JSON in VRC
let g:vrc_curl_opts = {
  \ '-i': ''
\}

" Having the JS syntax for Google Script
autocmd BufNewFile,BufRead *.gs set syntax=javascript

" Format for hours in my today
autocmd VimEnter * SpeedDatingFormat %H:%M

" Display correctly comments in json
autocmd FileType json syntax match Comment +\/\/.\+$+

nmap ]l <Plug>(coc-diagnostic-next)
nmap [l <Plug>(coc-diagnostic-prev)
nmap ]d <Plug>(coc-definition)
nmap <Leader>c <Plug>(coc-rename)
