"Load my bundles
source ~/dotfiles-pierrot/vimrc-plugins

" Leader is Space
let mapleader = "\<Space>"

" Live config edit
nmap <F7> :tabnew $HOME/.vimrc<ENTER>
nmap <F8> :source $HOME/.vimrc<ENTER>

" manage split size
nmap <C-W>H :vertical resize +5<cr>
nmap <C-W>L :vertical resize -5<cr>
nmap <C-W>K :resize -5<cr>
nmap <C-W>J :resize +5<cr>

" implicite :%s/old/new/g for :%s/old/new/
set gdefault

" scroll the page before the end of the window
set scrolloff=7

let g:syntastic_javascript_checkers = ['eslint']

let test#javascript#mocha#options = '--compilers js:babel-core/register'
nmap <silent> <leader>T :TestFile<CR>

" get in the current directory (local to the buffer with lcd)
map <leader>cd :lcd %:h<CR>

" CtrlP : ignore folders
let g:ctrlp_custom_ignore = '\v[\/](node_modules|target|dist)|(\.(swp|ico|git|svn))$'

" No more up/down arrows in command mode
cnoremap <C-k> <Up>
cnoremap <C-j> <Down>

" Create a file with <space>gf
map <leader>gf :e <cfile><cr>

colorscheme cobalt2

" Stop auto return
set textwidth=0
set wrapmargin=0
