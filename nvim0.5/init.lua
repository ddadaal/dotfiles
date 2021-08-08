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
    use 'onsails/lspkind-nvim'
    use 'nvim-lua/lsp-status.nvim'
    use 'hoob3rt/lualine.nvim'
    use {'ojroques/nvim-hardline'}
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

    use 'hrsh7th/vim-vsnip'
    use 'hrsh7th/vim-vsnip-integ'

    use '907th/vim-auto-save'

    use "lukas-reineke/indent-blankline.nvim"

    use 'akinsho/nvim-bufferline.lua'
    use 'romgrk/nvim-treesitter-context'

    use 'folke/lsp-colors.nvim'
    use {
        'folke/trouble.nvim',
        requires = 'kyazdani42/nvim-web-devicons',
        config = function() 
            require("trouble").setup {

            }
        end
    }

    -- plugin end
end)

-- Globals

vim.g.auto_save = 1

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

    inoremap <C-w> <C-\><C-o>dB
    inoremap <C-BS> <C-\><C-o>db
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

-- auto competion icon
require('lspkind').init({
    preset = 'codicons',
})

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
    capabilities.textDocument.completion.completionItem.resolveSupport = {
      properties = {
        'documentation',
        'detail',
        'additionalTextEdits',
      }
    }

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
    },
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

local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
    local col = vim.fn.col('.') - 1
    return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') ~= nil
end

-- Use (s-)tab to:
--- move to prev/next item in completion menuone
--- jump to prev/next snippet's placeholder
_G.tab_complete = function(orig_key)
  if vim.fn.pumvisible() == 1 then
    return t "<C-n>"
  elseif vim.fn['vsnip#available'](1) == 1 then
    return t "<Plug>(vsnip-expand-or-jump)"
  elseif check_back_space() then
    return t(orig_key)
  else
    return vim.fn['compe#complete']()
  end
end

_G.s_tab_complete = function(orig_key)
  if vim.fn.pumvisible() == 1 then
    return t "<C-p>"
  elseif vim.fn['vsnip#jumpable'](-1) == 1 then
    return t "<Plug>(vsnip-jump-prev)"
  else
    -- If <S-Tab> is not working in your terminal, change it to <C-h>
    return t(orig_key)
  end
end

local map_tab_complete = function(key)
    vim.api.nvim_set_keymap("i", key, "v:lua.tab_complete('" .. key .. "')", {expr = true})
    vim.api.nvim_set_keymap("s", key, "v:lua.tab_complete('" .. key .. "')", {expr = true})
end

local map_s_tab_complete = function(key)
    vim.api.nvim_set_keymap("i", key, "v:lua.s_tab_complete('" .. key .. "')", {expr = true})
    vim.api.nvim_set_keymap("s", key, "v:lua.s_tab_complete('" .. key .. "')", {expr = true})
end

map_tab_complete("<C-j>")
map_tab_complete("<Tab>")

map_s_tab_complete("<C-k>")
map_s_tab_complete("<S-Tab>")

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
        H = {"<C-W>H", "Move the window to the left"},
        J = {"<C-W>J", "Move the window down"},
        K = {"<C-W>K", "Move the window up"},
    },
    g = {
        name = "+git",
        s = {"<cmd>Magit<cr>", "Open Magit"}
    },
    h = {"<cmd>nohlsearch<cr>", "No Highlight"},
    b = {
        name = "+buffer",
        d = {"<cmd>bdelete<cr>", "Delete a buffer"},
        p = {":bp<cr>", "Previous Buffer"},
        n = {":bn<cr>", "Next Buffer"},
    }
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

-- bufferline
require'bufferline'.setup{
	options = {
            indicator_icon = ' ',
            buffer_close_icon = '',
            modified_icon = '●',
            close_icon = '',
            close_command = "bdelete %d",
            right_mouse_command = "bdelete! %d",
            left_trunc_marker = '',
            right_trunc_marker = '',
            offsets = {{filetype = "NvimTree", text = "EXPLORER", text_align = "center"}},
            show_tab_indicators = true,
            show_close_icon = false,
            diagnostics = "nvim_lsp",
	},
	highlights = {
		fill = {
			guifg = {attribute = "fg", highlight = "Normal"},
			guibg = {attribute = "bg", highlight = "StatusLineNC"},
		},
		background = {
			guifg = {attribute = "fg", highlight = "Normal"},
			guibg = {attribute = "bg", highlight = "StatusLine"}
		},
		buffer_visible = {
			gui = "",
            guifg = {attribute = "fg", highlight="Normal"},
            guibg = {attribute = "bg", highlight = "Normal"}
		},
		buffer_selected = {
			gui = "",
            guifg = {attribute = "fg", highlight="Normal"},
            guibg = {attribute = "bg", highlight = "Normal"}
		},
		separator = {
			guifg = {attribute = "bg", highlight = "Normal"},
			guibg = {attribute = "bg", highlight = "StatusLine"},
		},
		separator_selected = {
            guifg = {attribute = "fg", highlight="Special"},
            guibg = {attribute = "bg", highlight = "Normal"}
		},
		separator_visible = {
			guifg = {attribute = "fg", highlight = "Normal"},
			guibg = {attribute = "bg", highlight = "StatusLineNC"},
		},
		close_button = {
			guifg = {attribute = "fg", highlight = "Normal"},
			guibg = {attribute = "bg", highlight = "StatusLine"}
		},
		close_button_selected = {
            guifg = {attribute = "fg", highlight="normal"},
            guibg = {attribute = "bg", highlight = "normal"}
		},
		close_button_visible = {
            guifg = {attribute = "fg", highlight="normal"},
            guibg = {attribute = "bg", highlight = "normal"}
		},

	}
}
-- indent blankline
vim.cmd [[
    set listchars=space:⋅
    let g:indent_blankline_space_char_blankline = " "
    let g:indent_blankline_show_end_of_line = v:true
    let g:indentLine_fileTypeExclude = ['dashboard']
]]

require'treesitter-context'.setup{
    enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
    throttle = true, -- Throttles plugin updates (may improve performance)
}




