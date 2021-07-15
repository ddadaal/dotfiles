local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
    execute 'packadd packer.nvim'
end

-- Plugins

require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'
    use 'neovim/nvim-lspconfig'
    use 'kabouzeid/nvim-lspinstall'
    use 'kyazdani42/nvim-web-devicons'
    use 'nvim-lua/popup.nvim'
    use 'nvim-lua/plenary.nvim'
    use {
        'nvim-telescope/telescope.nvim',
        'windwp/nvim-spectre',
        requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}}
    }
    use 'nvim-treesitter/nvim-treesitter'
    use 'p00f/nvim-ts-rainbow'
    use 'hrsh7th/nvim-compe'
    use 'nvim-lua/lsp-status.nvim'
    use 'hoob3rt/lualine.nvim'
    use 'Mofiqul/vscode.nvim'
    use 'kyazdani42/nvim-tree.lua'
    use 'cohama/lexima.vim'
    use {
        'AckslD/nvim-whichkey-setup.lua',
        requires = {'liuchengxu/vim-which-key'}
    }
    use 'wakatime/vim-wakatime'
    use 'jamestthompson3/nvim-remote-containers'
    use {
        'glepnir/dashboard-nvim',
    }

    use "tpope/vim-surround"
    use {
        'machakann/vim-highlightedyank',
    }
    use 'editorconfig/editorconfig-vim'
    use 'simeji/winresizer'
    use 'terryma/vim-multiple-cursors'
    use 'jreybert/vimagit'
    use 'vim-test/vim-test'
    use 'b3nj5m1n/kommentary'

    use 'vimlab/split-term.vim'

    -- plugin end
end)

-- Globals

vim.g.dashboard_default_executive = "telescope"
vim.g.highlightedyank_highlight_duration = 200

vim.g["test#strategy"] = "neovim"

vim.g.mapleader = " "
vim.cmd [[
    set number
    set relativenumber
    command! Nconf :e $MYVIMRC
    set splitright
    set splitbelow

    set mouse=a

    set shiftwidth=4
    set autoindent
    set smartindent
    set smarttab
    set expandtab

    set ignorecase
    set smartcase

    set wrap
    set linebreak
]]


-- Lua Line
require('lualine').setup {
    options = {
        theme = 'vscode'
    },
    sections = {
        lualine_c = {"os.data('%a')", 'data', require'lsp-status'.status}
    }
}

-- LSP Config

-- keymaps
local on_attach = function(client, bufnr)
    local function buf_set_keymap(...)
        vim.api.nvim_buf_set_keymap(bufnr, ...)
    end
    local function buf_set_option(...)
        vim.api.nvim_buf_set_option(bufnr, ...)
    end

    buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings.
    local opts = {
        noremap = true,
        silent = true
    }
    buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
    buf_set_keymap('n', 'gh', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
    buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    --[[ buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
    buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
    buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts) ]]
    buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    buf_set_keymap('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    -- buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
    buf_set_keymap('n', 'g[', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
    buf_set_keymap('n', 'g]', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
    buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)

    -- Set some keybinds conditional on server capabilities
    if client.resolved_capabilities.document_formatting then
        buf_set_keymap("n", "<A-S-f>", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
    elseif client.resolved_capabilities.document_range_formatting then
        buf_set_keymap("n", "<A-S-f>", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
    end

    -- Set autocommands conditional on server_capabilities
    if client.resolved_capabilities.document_highlight then
        vim.api.nvim_exec([[
    augroup lsp_document_highlight
    autocmd! * <buffer>
    autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
    autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
    augroup END
    ]], false)
    end
end

-- config that activates keymaps and enables snippet support
local function make_config()
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities.textDocument.completion.completionItem.snippetSupport = true
    return {
        -- enable snippet support
        capabilities = capabilities,
        -- map buffer local keybindings when the language server attaches
        on_attach = on_attach
    }
end

local lspconfig = require('lspconfig')

local lspinstall = require'lspinstall'

lspinstall.setup()

local servers = lspinstall.installed_servers()
-- local servers = { 'tsserver', 'sumneko_lua' }

for _, server in pairs(servers) do
    local config = make_config()

    lspconfig[server].setup(config)
end

-- nvim-compe

vim.o.completeopt = "menuone,noselect"
require'compe'.setup {
    source = {
        path = true,
        buffer = true,
        calc = true,
        nvim_lsp = true,
        nvim_lua = true,
        vsnip = true,
        ultisnips = true
    }
}

vim.cmd [[
    let g:lexima_no_default_rules = v:true
    call lexima#set_default_rules()
    inoremap <silent><expr> <C-Space> compe#complete()
    inoremap <silent><expr> <CR>      compe#confirm(lexima#expand('<LT>CR>', 'i'))
    inoremap <silent><expr> <C-e>     compe#close('<C-e>')
    inoremap <silent><expr> <C-f>     compe#scroll({ 'delta': +4 })
    inoremap <silent><expr> <C-d>     compe#scroll({ 'delta': -4 })
]]

-- Theme
vim.g.vscode_style = "dark"
vim.cmd [[colorscheme vscode]]

-- Keybindings
local leader_keymap = {
    e = {'<Cmd>NvimTreeToggle<CR>', "Toggle NvimTree"},
    f = {
        name = "+file",
        f = {'<cmd>lua require(\'telescope.builtin\').find_files()<cr>', "Telescope Find File"},
        g = {'<cmd>lua require(\'telescope.builtin\').live_grep()<cr>', "Telescope Live Grep"},
        b = {'<cmd>lua require(\'telescope.builtin\').buffers()<cr>', "Telescope Buffers"},
        h = {'<cmd>lua require(\'telescope.builtin\').help_tags()<cr>', "Telescope Help Tags"}
    },
    r = {
        name = "+replace",
        f = {"<cmd>lua require('spectre').open_file_search()<cr>", "Current File"},
        p = {"<cmd>lua require('spectre').open()<cr>", "Project"}
    },
    w = {
        name = "+window",
        a = {":WinResizerStartResize<cr>"},
        h = {"<C-W>h", "Focus the window at left"},
        j = {"<C-W>j", "Focus the window down"},
        k = {"<C-W>k", "Focus the window up"},
        l = {"<C-W>l", "Focus the window at right"},
        d = {"<C-W>q", "Close current window"},
        L = {"<C-W>L", "Move the window to the right"},
        H = {"<C-W>L", "Move the window to the left"},
        J = {"<C-W>L", "Move the window down"},
        K = {"<C-W>L", "Move the window up"},
    },
    g = {
        name = "+git",
        s = {"<cmd>Magit<cr>", "Open Magit"}
    },
    h = {"<cmd>nohlsearch<cr>", "No Highlight"}
}

vim.cmd [[
    vnoremap <C-c> "+y
    nmap <C-c> "+yy
    imap <C-v> <esc>"+pi
    nmap <C-a> ggVG

    nnoremap <A-j> <C-W>j
    nnoremap <A-k> <C-W>k
    nnoremap <A-h> <C-W>h
    nnoremap <A-l> <C-W>l
]]




local whichkey = require 'whichkey_setup'
whichkey.register_keymap('leader', leader_keymap)

-- nvim-spectre
require('spectre').setup({})

-- nvim-remote-containers

-- treesitter
require'nvim-treesitter.configs'.setup {
  rainbow = {
    enable = true,
    extended_mode = true, -- Highlight also non-parentheses delimiters, boolean or table: lang -> boolean
    max_file_lines = 1000, -- Do not enable for files with more than 1000 lines, int
  }
}

-- comment
-- require('nvim_comment').setup()
-- vim.cmd [[
--     nnoremap <c-_> <cmd>commenttoggle<cr>
--     vnoremap <c-_> <cmd>commenttoggle<cr>
-- ]]

vim.api.nvim_set_keymap("n", "<C-_>", "<Plug>kommentary_line_default", {})
vim.api.nvim_set_keymap("x", "<C-_>", "<Plug>kommentary_visual_default", {})


-- tree
vim.g.nvim_tree_auto_open = 1
vim.g.nvim_tree_auto_close = 1
vim.g.nvim_tree_lsp_diagnostics = 1

vim.cmd [[
    set termguicolors
]]

local tree_cb = require'nvim-tree.config'.nvim_tree_callback
-- allow l to enter a file
vim.g.nvim_tree_bindings = {
    { key = 'l', cb = tree_cb("edit") },
}
