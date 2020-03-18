" =============================================
" plugins part
" ==============================================
call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-surround'

Plug 'tomasiser/vim-code-dark'

Plug 'honza/vim-snippets'

Plug 'sheerun/vim-polyglot'

Plug 'neoclide/coc.nvim', { 'branch': 'release' } 

let g:coc_global_extensions = [
 \ 'coc-tsserver',
 \ 'coc-css',
 \ 'coc-json',
 \ 'coc-eslint',
 \ 'coc-rust-analyzer',
 \ 'coc-python',
 \ 'coc-snippets',
 \ 'coc-explorer',
 \ 'coc-omnisharp',
 \ ]

" Plug 'preservim/nerdtree'
"
Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(0) } }

" gcc to comment, gc in visual
Plug 'tpope/vim-commentary'

" <leader> motion to move cursor
Plug 'bkad/CamelCaseMotion'

" light replacement for airline
Plug 'itchyny/lightline.vim'

" add buffers as tab line
Plug 'ap/vim-buftabline'

" :Startify to show homepage
Plug 'mhinz/vim-startify'

" :Rooter
Plug 'airblade/vim-rooter'

" Fuzzy search
Plug 'Yggdroot/LeaderF'

" :MarkdownPreview(Stop)
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() } }

Plug 'styled-components/vim-styled-components', { 'branch': 'main' }
Plug 'wakatime/vim-wakatime'

Plug 'machakann/vim-highlightedyank'

Plug 'editorconfig/editorconfig-vim'
Plug 'jiangmiao/auto-pairs'

Plug 'vim-scripts/vim-auto-save'

Plug 'tpope/vim-fugitive'

" Disable search highlight after search
Plug 'romainl/vim-cool'

Plug 'frazrepo/vim-rainbow'

Plug 'mattn/emmet-vim'

" typescript and javascript highlighting
" polyglot's yats.vim is not as good
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'

" in selection, press * to find all other instances in the buffer
" :%s//<replacement>/g to use the last search pattern and replace them
Plug 'nelstrom/vim-visual-star-search'

" + zoom in, - zoom out
Plug 'vim-scripts/zoom.vim'

" Select word Ctrl-N, and then n/N to select occurrenses (q skip), [/] to select cursor(Q skip)
" Ctrl-Down/Up to create cursors
Plug 'mg979/vim-visual-multi', {'branch': 'master'}

" Extend %
Plug 'andymass/vim-matchup'

" Open terminal in another pane 
" :Term horizontally, :VTerm vertically
Plug 'vimlab/split-term.vim'

" s<char><char> jump to closest <char><char> occurrences
" ; after sneak to jump to next
" s<Enter> repeat last search
" Plug 'justinmk/vim-sneak'

" <leader><leader>w to start jumping to words
" <leader><leader>f<char> to start jumping to <char>
Plug 'easymotion/vim-easymotion'

Plug 'ryanoasis/vim-devicons'

call plug#end()

" =============================================
" main part
" ==============================================

set showmatch
set number
colorscheme codedark

" disable netrw
let loaded_netrwPlugin = 1

" Set SPC as the leader key
let mapleader = " " 

" Disable ts for polyglot
let g:polyglot_disabled = ['typescript']

" Short highlighted yank duration
let g:highlightedyank_highlight_duration = 300

" Leaderf
" don't show the help in normal mode
let g:Lf_HideHelp = 1
let g:Lf_UseCache = 0
let g:Lf_UseVersionControlTool = 0
let g:Lf_IgnoreCurrentBufferName = 1
" popup mode
let g:Lf_WindowPosition = 'popup'
let g:Lf_PreviewInPopup = 1
let g:Lf_StlSeparator = { 'left': "\ue0b0", 'right': "\ue0b2", 'font': "DejaVu Sans Mono for Powerline" }
let g:Lf_PreviewResult = {'Function': 0, 'BufTag': 0 }

let g:Lf_ShortcutF = "<leader>ff"
noremap <leader>fb :<C-U><C-R>=printf("Leaderf buffer %s", "")<CR><CR>
noremap <leader>fm :<C-U><C-R>=printf("Leaderf mru %s", "")<CR><CR>
noremap <leader>ft :<C-U><C-R>=printf("Leaderf bufTag %s", "")<CR><CR>
noremap <leader>fl :<C-U><C-R>=printf("Leaderf line %s", "")<CR><CR>

noremap <leader>fg :Leaderf rg -e 
noremap <C-B> :<C-U><C-R>=printf("Leaderf! rg --current-buffer -e %s ", expand("<cword>"))<CR>
noremap <C-F> :<C-U><C-R>=printf("Leaderf! rg -e %s ", expand("<cword>"))<CR>
" search visually selected text literally
xnoremap gf :<C-U><C-R>=printf("Leaderf! rg -F -e %s ", leaderf#Rg#visual())<CR>
noremap go :<C-U>Leaderf! rg --recall<CR>

" should use `Leaderf gtags --update` first
let g:Lf_GtagsAutoGenerate = 0
let g:Lf_Gtagslabel = 'native-pygments'
noremap <leader>fr :<C-U><C-R>=printf("Leaderf! gtags -r %s --auto-jump", expand("<cword>"))<CR><CR>
noremap <leader>fd :<C-U><C-R>=printf("Leaderf! gtags -d %s --auto-jump", expand("<cword>"))<CR><CR>
noremap <leader>fo :<C-U><C-R>=printf("Leaderf! gtags --recall %s", "")<CR><CR>
noremap <leader>fn :<C-U><C-R>=printf("Leaderf gtags --next %s", "")<CR><CR>
noremap <leader>fp :<C-U><C-R>=printf("Leaderf gtags --previous %s", "")<CR><CR>

" easymotion config

let g:EasyMotion_smartcase = 1

" use easymotion to replace search
" map  / <Plug>(easymotion-sn)
" omap / <Plug>(easymotion-tn)

" map  n <Plug>(easymotion-next)
" map  N <Plug>(easymotion-prev)

" Show search count
let g:CoolTotalMatches = 1

" Enable rainbow parathensis
let g:rainbow_active = 1

" Enable auto save, and disable it in insert mode
" Only save change on leaving insert and text change
" :e! to forcefully reload current file if it is changed externally
let g:auto_save = 1
let g:auto_save_in_insert_mode = 0
let g:auto_save_events = ["InsertLeave", "TextChanged"]

" Auto reload file when changed
" Triger `autoread` when files changes on disk
" https://unix.stackexchange.com/questions/149209/refresh-changed-content-of-file-opened-in-vim/383044#383044
" https://vi.stackexchange.com/questions/13692/prevent-focusgained-autocmd-running-in-command-line-editing-mode
autocmd FocusGained,BufEnter,CursorHold,CursorHoldI *
        \ if mode() !~ '\v(c|r.?|!|t)' && getcmdwintype() == '' | checktime | endif

" Notification after file change
" https://vi.stackexchange.com/questions/13091/autocmd-event-for-autoread
autocmd FileChangedShellPost *
  \ echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None


" Enable camel case motion
let g:camelcasemotion_key = '<leader>'


" Alt + Motion: Move pane in order 
map <A-j> <C-W>j
map <A-k> <C-W>k
map <A-h> <C-W>h
map <A-l> <C-W>l

" Leader A to open coc-explorer
map <A-a> :CocCommand explorer<CR>

" Leader A to open NERDTree, CD: set tree node to CWD
" map <A-a> :NERDTreeToggle<CR>

" Show hidden file
" let NERDTreeShowHidden = 1

" Ctrl C, Ctrl V, Ctrl A
vnoremap <C-c> "+y
nmap <C-c> "+yy
imap <C-v> "+p
vmap <C-a> ggVG

" :Cdh to cd to the file folder
command! Cdh :cd %:h

" :Nconf to open init.vim
command! Nconf :e $MYVIMRC
command! Gnconf :e $MYVIMRC/../ginit.vim

" :Bc or Alt-q to close current buffer and show the previous (p) buffer
command! Bc :bp | bd#
map <A-q> :Bc<CR>

" indent stuff
set autoindent
set smartindent
set smarttab
set expandtab
set shiftwidth=4

" when searching, input lowercase ignores case
set ignorecase
set smartcase

filetype plugin indent on

" Set MD as markdown
au BufRead,BufNewFile *.MD setlocal filetype=markdown
" au BufRead,BufNewFile *.tsx setlocal filetype=typescript.tsx

" Show startify when no buffer is opened
"autocmd BufDelete * if empty(filter(tabpagebuflist(), '!buflisted(v:val)')) | Startify | endif

" Enable airline tabline
" let g:airline#extensions#tabline#enabled = 1

" <Alt>-, and <Alt>-. to switch between buffers
nmap <A-,> :bprev<CR>
nmap <A-.> :bnext<CR>

" disable auto rooter, call :Rooter to jump.
let g:rooter_manual_only =1
let g:rooter_patterns = ['package.json',  '.git/', '*.sln']

" Font, NerdFont patched Cascadia Code
" set guifont=CaskaydiaCove\ NF:h12

" Add icon to airline
" let g:airline_powerline_fonts = 1

" lightline.vim shows the mode already
set noshowmode

" disable backup files
set noundofile
set noswapfile

" Set PowerShell as default terminal
" Will break vim-plug
" set shell=powershell

" Set Powershell as the shell for split-term.vim
let g:split_term_default_shell = "powershell"

" :Term at below, :VTerm at right
set splitright
set splitbelow

" =============================================
" coc.nvim part
" ==============================================
" Alt Shift F to format
map <A-S-f> :Format<CR>
"
" if hidden is not set, TextEdit might fail.
set hidden

" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

" Better display for messages
set cmdheight=1

" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:coc_snippet_next = '<tab>'

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" Or use `complete_info` if your vim support it, like:
" inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `g[` and `g]` to navigate diagnostics
nmap <silent> g[ <Plug>(coc-diagnostic-prev)
nmap <silent> g] <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
" Sync with VSCode using F2
nmap <F2> <Plug>(coc-rename)

" Remap for format selected region
"xmap <leader>f  <Plug>(coc-format-selected)
"nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Create mappings for function text object, requires document symbols feature of languageserver.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <TAB> for select selections ranges, needs server support, like: coc-tsserver, coc-python
nmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <TAB> <Plug>(coc-range-select)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add status line support, for integration with other plugin, checkout `:h coc-status`
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Using CocList
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

" Integrate to lightline

function! CocCurrentFunction()
    return get(b:, 'coc_current_function', '')
endfunction

let g:lightline = {
      \ 'colorscheme': 'powerline',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'cocstatus', 'currentfunction', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'cocstatus': 'coc#status',
      \   'currentfunction': 'CocCurrentFunction'
      \ },
      \ }

