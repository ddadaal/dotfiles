call plug#begin('~/.vim/plugged')
Plug 'neovim/nvim-lsp'
call plug#end()

set number

lua << EOF
  require'nvim_lsp'.rust_analyzer.setup{}
EOF

