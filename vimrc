"Load my bundles
source ~/dotfiles-pierrot/vimrc-plugins

" THEME
syntax on
set t_Co=256
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
colorscheme OceanicNext

" Leader is Space
let mapleader = "\<Space>"
nmap <F8> :source $HOME/.vimrc<ENTER>

" manage split size
nmap <C-W>H :vertical resize +5<cr>
nmap <C-W>L :vertical resize -5<cr>
nmap <C-W>K :resize -5<cr>
nmap <C-W>J :resize +5<cr>

" implicite :%s/old/new/g for :%s/old/new/
set gdefault

" No more up/down arrows in command mode
cnoremap <C-k> <Up>
cnoremap <C-j> <Down>

" Create a file with <space>gf
map <leader>gf :e <cfile><cr>

set number              " Display lines number

set autoindent          " copy indent from current line when starting a new line
set expandtab           " use the appropriate number of spaces to insert a tab
set tabstop=2           " number of spaces that a <Tab> in the file counts for
set shiftwidth=2        " number of spaces to use for each step of (auto)indent

set ruler               " show the current line and column number
set hlsearch            " highlight searches
set incsearch           " do incremental searching
set showmatch           " jump to matches when entering regexp
set ignorecase          " ignore case when searching
set smartcase           " no ignorecase if Uppercase char present

set inccommand=nosplit  "Shows the effects of a command incrementally, as you type.

set showcmd             " display incomplete commands
set nobackup            " do not keep a backup file

set autoread            " change outside of Vim: automatically read it again.
set scrolloff=4         " scroll the page before the end of the window

" ####### PLUGINS
let g:syntastic_javascript_checkers = ['eslint']

let test#javascript#mocha#options = '--compilers js:babel-core/register'
nmap <silent> <leader>T :TestFile<CR>

" get in the current directory (local to the buffer with lcd)
map <leader>cd :lcd %:h<CR>

" CtrlP : ignore folders
let g:ctrlp_custom_ignore = '\v[\/](node_modules|target|dist)|(\.(swp|ico|git|svn))$'

" Leave terminal mode with escape
tnoremap <Esc> <C-\><C-n>
