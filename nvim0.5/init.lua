local execute = vim.api.nvim_command
local fn = vim.fn

-- verb object

-- Bootstrap paq
local install_path = fn.stdpath('data') .. '/site/pack/paqs/start/paq-nvim'

if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', 'https://github.com/savq/paq-nvim.git', install_path})
end

-- Plugins

require('paq-nvim') {'savq/paq-nvim', 'neovim/nvim-lspconfig', 'kabouzeid/nvim-lspinstall', 'nvim-lua/popup.nvim',
                     'nvim-lua/plenary.nvim', 'nvim-telescope/telescope.nvim', 'nvim-treesitter/nvim-treesitter',
                     'hrsh7th/nvim-compe', 'kyazdani42/nvim-web-devicons', 'hoob3rt/lualine.nvim',
                     'Mofiqul/vscode.nvim', 'kyazdani42/nvim-tree.lua', 'glepnir/lspsaga.nvim', 'cohama/lexima.vim',
                     'nvim-lua/lsp-status.nvim', 'liuchengxu/vim-which-key', 'AckslD/nvim-whichkey-setup.lua'}

-- Globals

vim.g.mapleader = " "
vim.cmd [[
    set number
    set relativenumber
    command! Nconf :e $MYVIMRC
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
    buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
    buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
    buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
    buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
    buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
    buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
    buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
    buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)

    -- Set some keybinds conditional on server capabilities
    if client.resolved_capabilities.document_formatting then
        buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
    elseif client.resolved_capabilities.document_range_formatting then
        buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
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

local servers = {'tsserver', 'pyright', 'gopls'}

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

-- nvimtree.lua

vim.cmd [[
    nnoremap <leader>ft :NvimTreeToggle<CR>
    nnoremap <leader>fr :NvimTreeRefresh<CR>
]]

-- lspsaga.nvim
-- local saga = require 'saga'
-- saga.init_lsp_saga()

-- vim.cmd [[
--     nnoremap <silent><leader>ca <cmd>lua require('lspsaga.codeaction').code_action()<CR>
-- ]]

-- Theme
vim.g.vscode_style = "dark"
vim.cmd [[colorscheme vscode]]

-- Keybindings
local keymap = {
    f = {
        name = "+file",
        t = {'<Cmd>NvimTreeToggle<CR>', "Toggle NvimTree"},
        r = {'<Cmd>NvimTreeRefresh<CR>', "Refresh NvimTree"},
        f = {'<cmd>lua require(\'telescope.builtin\').find_files()<cr>', "Telescope Find File"},
        g = {'<cmd>lua require(\'telescope.builtin\').live_grep()<cr>', "Telescope Live Grep"},
        b = {'<cmd>lua require(\'telescope.builtin\').buffers()<cr>', "Telescope Buffers"},
        h = {'<cmd>lua require(\'telescope.builtin\').help_tags()<cr>', "Telescope Help Tags"}
    }
}

require("whichkey_setup").register_keymap('leader', keymap)

