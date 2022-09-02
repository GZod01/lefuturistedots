-- TODO
-- Completion
-- Debugger feature
-- Twig treesitter support
-- Refactor helpers
-- Change name of variable with LSP??
-- Tabs features?? Or recent tabs?

local opt = vim.opt

opt.number = true
opt.relativenumber = true
opt.hidden = true

-- Tabs options
opt.autoindent = true
opt.cindent = true
opt.wrap = true

opt.expandtab = true
opt.smartindent = true

opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4

opt.breakindent = true
opt.showbreak = string.rep(" ", 3) -- Make it so that long lines wrap smartly
opt.linebreak = true

--

opt.wildmenu = true
opt.updatetime = 50
opt.termguicolors = true

opt.signcolumn = 'yes'
opt.belloff = 'all'

opt.scrolloff = 10

-- Always ignore case when searching, unless there is a capital letter in the query
opt.ignorecase = true
opt.smartcase = true

opt.splitright = true
opt.splitbelow = true

-- Cool floating window popup menu for completion on command line
opt.pumblend = 17
opt.wildmode = "longest:full"
opt.wildoptions = "pum"

-- Ignore compiled files
opt.wildignore = "__pycache__"
opt.wildignore:append { "*.o", "*~", "*.pyc", "*pycache*" }
opt.wildignore:append "Cargo.lock"

-- Highlight on yank (copy). It will do a nice highlight blink of the thing you just copied.
vim.api.nvim_exec(
  [[
  augroup YankHighlight
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank()
  augroup end
]],
  false
)

vim.g.mapleader = " "

require("packer").startup(function()
    use("wbthomason/packer.nvim")

    use("nvim-lua/plenary.nvim")
    use("nvim-lua/popup.nvim")
    use("nvim-telescope/telescope.nvim")

    -- Language Server Protocol stuff
    use("neovim/nvim-lspconfig")
    --use("hrsh7th/cmp-nvim-lsp")
    --use("hrsh7th/cmp-buffer")
    --use("hrsh7th/nvim-cmp")

    --use("williamboman/mason.nvim")


    -- Tree sitter stuff
    use("nvim-treesitter/nvim-treesitter", {
        run = ":TSUpdate"
    })
    use("nvim-treesitter/playground")
    use {
        "nvim-treesitter/nvim-treesitter-textobjects"
    }
    use {
        "nvim-treesitter/nvim-treesitter-context",
        config = function ()
            require("treesitter-context").setup{
                enable = true
            }
        end
    }
    use {
        "JoosepAlviste/nvim-ts-context-commentstring",
        config = function ()
            require("nvim-treesitter.configs").setup{
                context_commentstring = {enable = true} 
            }
        end
    }
    use("tpope/vim-commentary")

    -- Git integration
    -- use("tpope/vim-fugitive")
    use {
        'TimUntersberger/neogit',
        requires = 'nvim-lua/plenary.nvim',
        config = function ()
            require('neogit').setup{
                disable_builtin_notifications = true
            }
        end
    }
    use {
        'lewis6991/gitsigns.nvim',
        config = function ()
            require('gitsigns').setup()
        end
    }

    -- Format
    use("sbdchd/neoformat")
    
    use {
      "folke/trouble.nvim",
      requires = "kyazdani42/nvim-web-devicons",
      config = function()
          require("trouble").setup {
          }
      end
    }

    use {
        "windwp/nvim-autopairs",
        config = function() require("nvim-autopairs").setup {} end
    }

    -- Enhanced increment and decrement
    use("monaqa/dial.nvim")

    -- Toggle helper
    -- plugin to toggle boolean values
    use("rmagatti/alternate-toggler")

    -- File navigation helper
    use {
        "ThePrimeagen/harpoon",
        -- config = function()
        --     require('harpoon').setup({

        --     })
        -- end
    }

    -- Colorscheme section
    use("gruvbox-community/gruvbox")
    use("RRethy/nvim-base16")
    use("kyazdani42/nvim-palenight.lua")
    use("folke/tokyonight.nvim")
    use("bluz71/vim-moonfly-colors")

    -- use("ryanoasis/vim-devicons")
    use {
        'kyazdani42/nvim-web-devicons',
        config = function()
			require'nvim-web-devicons'.setup {
				-- your personnal icons can go here (to override)
				-- you can specify color or cterm_color instead of specifying both of them
				-- DevIcon will be appended to `name`
				override = {
					vue = {
						icon = "",
						color = "#428850",
						cterm_color = "65",
						name = "Vue"
					}
				};
				-- globally enable default icons (default to false)
				-- will get overriden by `get_icons` option
				default = true;
			}
        end
    }

    -- Add Sticky Buffers
    use("stevearc/stickybuf.nvim")

    use {
        "ur4ltz/surround.nvim",
        config = function()
            require"surround".setup {mappings_style = "sandwich"}
        end
    }
    use {
        "mfussenegger/nvim-treehopper"
    }
    use {
        "phaazon/hop.nvim",
        config = function()
            require("hop").setup()
        end
    }
    -- Align things by comma
    -- use : `:Tabularize /,`
    -- It would be nicer if someone (me?) could develop a plugin that is based on treesitter and can automagically detect when it's a array, object etc.
    use("godlygeek/tabular")
    -- use {
    --     'romgrk/barbar.nvim',
    --     requires = {'kyazdani42/nvim-web-devicons'}
    -- }
    
    -- Implement the editorconfig specification (format rules for each project)       
    use('editorconfig/editorconfig-vim')

    -- Language config
    -- Use emmet
    use('mattn/emmet-vim')

    -- Consider using https://github.com/danymat/neogen to easily create functions annotation (can support php docs)
    use('lumiliet/vim-twig')
    -- use('lervag/vimtex') -- tex support is already here?
end)


-- local map = vim.api.nvim_set_keymap
local map = vim.keymap.set

-- access to system clipboard
map("n", "Y", '"+y')
map("v", "Y", '"+y')

-- handy little things
map("n", "<C-q>", "<Cmd>:q<CR>")
map("n", "<C-s>", "<Cmd>:w<CR>")

-- back to last buffer
map("n", "<Leader>bb", "<C-^>")

-- No highlights
map("n", "<Leader>nh", "<Cmd>noh<CR>")

-- Harpoon
map("n", "<Leader>h", function() require("harpoon.ui").toggle_quick_menu() end)
map("n", "<Leader>a", function() require("harpoon.mark").add_file() end)
map("n", "<A-h>", function () require("harpoon.ui").nav_file(1) end)
map("n", "<A-j>", function () require("harpoon.ui").nav_file(2) end)
map("n", "<A-k>", function () require("harpoon.ui").nav_file(1) end)

-- Dial: Improved increment
map("n", "<C-a>", require("dial.map").inc_normal(), {noremap = true})
map("n", "<C-x>", require("dial.map").dec_normal(), {noremap = true})
map("v", "<C-a>", require("dial.map").inc_visual(), {noremap = true})
map("v", "<C-x>", require("dial.map").dec_visual(), {noremap = true})
map("v", "g<C-a>", require("dial.map").inc_gvisual(), {noremap = true})
map("v", "g<C-x>", require("dial.map").dec_gvisual(), {noremap = true})

-- let g:at_custom_alternates = {'===': '!==', 'yes':'no'}
-- vim.cmd [[
--     let g:at_custom_alternates = {'===': '!==', 'yes': 'no'}
-- ]]

-- https://github.com/rmagatti/alternate-toggler/issues/6
vim.g.at_custom_alternates = {
    ['==='] = '!==',
    ['yes'] = 'no',
    ['open'] = 'close',
    ['always'] = 'never',
    ['allow'] = 'deny',
    ['before'] = 'after',
    ['let'] = 'var',
    ['public'] = 'private',
    ['begin'] = 'end'
}

map("n", "<Leader>ta", "<Cmd>:ToggleAlternate<CR>")

map("n", "<Leader>ff", function ()
  require('telescope.builtin').find_files()
end)

map("n", "<C-p>", function ()
  require('telescope.builtin').find_files()
end)

map("n", "<Leader>fg", function ()
  require('telescope.builtin').live_grep()
end)

map("n", "<Leader>fb", function ()
  require('telescope.builtin').buffers()
end)

map("n", "<Leader>fh", function ()
  require('telescope.builtin').help_tags()
end)

vim.cmd("colorscheme gruvbox")
vim.opt.background = "dark"
vim.g.gruvbox_contrast_dark = "hard"

require'nvim-treesitter.configs'.setup {
    ensure_installed = "all",
    sync_install = false,

    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
    indent = {
        enable = true
    },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "<C-n>",
        node_incremental = "<C-n>",
        scope_incremental = "<C-s>",
        node_decremental = "<C-r>",
      },
    },
    textobjects = {
        select = {
           enable = true,

           -- Automatically jump forward to textobj, similar to targets.vim
           lookahead = true,

           keymaps = {
             -- You can use the capture groups defined in textobjects.scm
             ["af"] = "@function.outer",
             ["if"] = "@function.inner",
             ["ac"] = "@class.outer",
             ["ic"] = "@class.inner",
           },
           -- You can choose the select mode (default is charwise 'v')
           selection_modes = {
             ['@parameter.outer'] = 'v', -- charwise
             ['@function.outer'] = 'V', -- linewise
             ['@class.outer'] = '<c-v>', -- blockwise
           },
           -- If you set this to `true` (default is `false`) then any textobject is
           -- extended to include preceding xor succeeding whitespace. Succeeding
           -- whitespace has priority in order to act similarly to eg the built-in
           -- `ap`.
           include_surrounding_whitespace = true,
        },
    },
}

vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldlevelstart = 20



local nvim_lsp = require 'lspconfig'
local servers = { 'clangd', 'rust_analyzer', 'pyright', 'tsserver', 'gopls' }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end
nvim_lsp.phpactor.setup{
    on_attach = on_attach,
    init_options = {
        ["language_server_phpstan.enabled"] = false,
        ["language_server_psalm.enabled"] = false,
    }
}


local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, 'lua/?.lua')
table.insert(runtime_path, 'lua/?/init.lua')

-- Language server keybindings
map("n", "gd", function ()
  vim.lsp.buf.definition()
end)

map("n", "gD", function ()
  vim.lsp.buf.declaration()
end)

map("n", "gi", function ()
  vim.lsp.buf.implementation()
end)

map("n", "gw", function ()
  vim.lsp.buf.document_symbol()
end)

map("n", "gr", function ()
  vim.lsp.buf.references()
end)

map("n", "<Leader>td", function ()
  vim.lsp.buf.type_definition()
end)

map("n", "K", function ()
  vim.lsp.buf.hover()
end)

map("n", "<c-k>", function ()
  vim.lsp.buf.signature_help()
end)

map("n", "<Leader>af", function ()
  vim.lsp.buf.code_action()
end)

map("n", "<Leader>rn", function ()
  vim.lsp.buf.rename()
end)


-- Tabs keymaps

-- -- Move to previous/next
-- map('n', '<A-,>', '<Cmd>BufferPrevious<CR>')
-- map('n', '<A-.>', '<Cmd>BufferNext<CR>')
-- -- Re-order to previous/next
-- map('n', '<A-<>', '<Cmd>BufferMovePrevious<CR>')
-- map('n', '<A->>', '<Cmd>BufferMoveNext<CR>')
-- -- Goto buffer in position...
-- map('n', '<A-1>', '<Cmd>BufferGoto 1<CR>')
-- map('n', '<A-2>', '<Cmd>BufferGoto 2<CR>')
-- map('n', '<A-3>', '<Cmd>BufferGoto 3<CR>')
-- map('n', '<A-4>', '<Cmd>BufferGoto 4<CR>')
-- map('n', '<A-5>', '<Cmd>BufferGoto 5<CR>')
-- map('n', '<A-6>', '<Cmd>BufferGoto 6<CR>')
-- map('n', '<A-7>', '<Cmd>BufferGoto 7<CR>')
-- map('n', '<A-8>', '<Cmd>BufferGoto 8<CR>')
-- map('n', '<A-9>', '<Cmd>BufferGoto 9<CR>')
-- map('n', '<A-0>', '<Cmd>BufferLast<CR>')
-- -- Pin/unpin buffer
-- map('n', '<A-p>', '<Cmd>BufferPin<CR>')
-- -- Close buffer
-- map('n', '<A-c>', '<Cmd>BufferClose<CR>')
-- -- Wipeout buffer
-- --                 :BufferWipeout
-- -- Close commands
-- --                 :BufferCloseAllButCurrent
-- --                 :BufferCloseAllButPinned
-- --                 :BufferCloseAllButCurrentOrPinned
-- --                 :BufferCloseBuffersLeft
-- --                 :BufferCloseBuffersRight
-- -- Magic buffer-picking mode
-- map('n', '<C-p>', '<Cmd>BufferPick<CR>')
-- -- Sort automatically by...
-- map('n', '<Space>bb', '<Cmd>BufferOrderByBufferNumber<CR>')
-- map('n', '<Space>bd', '<Cmd>BufferOrderByDirectory<CR>')
-- map('n', '<Space>bl', '<Cmd>BufferOrderByLanguage<CR>')
-- map('n', '<Space>bw', '<Cmd>BufferOrderByWindowNumber<CR>')

map("n", "<Leader>gh", "<Cmd>:lua print('this is a msg')<CR>")


