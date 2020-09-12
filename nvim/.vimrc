set noundofile
set noswapfile
set nobackup
set nowritebackup

set number relativenumber

let mapleader = " "

vnoremap <C-c> "+y
nmap <C-c> "+yy
imap <C-v> <esc>"+pi
vmap <C-a> ggVG

set showmatch

let mapleader = ' '

" Alt + Motion: Move pane in order 
nnoremap <A-j> <C-W>j
nnoremap <A-k> <C-W>k
nnoremap <A-h> <C-W>h
nnoremap <A-l> <C-W>l

" Alt + Left/Right/Up/Down to resize window
nnoremap <A-S-l> :vertical resize +3<CR>
nnoremap <A-S-h> :vertical resize -3<CR>
nnoremap <A-S-k> :resize +3<CR>
nnoremap <A-S-j> :resize -3<CR>

" indent stuff
set autoindent
set smartindent
set smarttab
set expandtab
set shiftwidth=4

" when searching, input lowercase ignores case
set ignorecase
set smartcase

nmap <A-,> :bprev<CR>
nmap <A-.> :bnext<CR>

" :Term at below, :VTerm at right
set splitright
set splitbelow

set hidden