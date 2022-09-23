require('impatient')

-- TODO
-- Completion
-- Debugger feature
-- Twig treesitter support
-- Refactor helpers
-- Change name of variable with LSP??
-- Tabs features?? Or recent tabs?

local opt = vim.opt

vim.cmd("set background=dark")

opt.background = "dark"
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
-- use [[ ]] to do multi-line strings
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

    use("lewis6991/impatient.nvim")

    use("nvim-lua/plenary.nvim")
    use("nvim-lua/popup.nvim")
    use("nvim-telescope/telescope.nvim")

    use {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v2.x",
        requires = { 
            "nvim-lua/plenary.nvim",
            "kyazdani42/nvim-web-devicons", -- not strictly required, but recommended
            "MunifTanjim/nui.nvim",
        }
    }

    -- Language Server Protocol stuff
    use("neovim/nvim-lspconfig")
    use("hrsh7th/nvim-cmp")
    use("hrsh7th/cmp-nvim-lsp")
    use("hrsh7th/cmp-buffer")
    use("hrsh7th/cmp-path")
    use("ray-x/cmp-treesitter")
    use("saadparwaiz1/cmp_luasnip")


    use {
        "L3MON4D3/LuaSnip",
        config = function ()
            require("luasnip").config.set_config({
                history = true,
                updateevents = "TextChanged,TextChangedI",
                enable_autosnippets = true,
            })
        end
    }
    use("rafamadriz/friendly-snippets")

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
    -- use treesitter to auto add HTML tags
    use {
        'windwp/nvim-ts-autotag',
        config = function ()
            require('nvim-ts-autotag').setup({
                autotag = {
                    enable = true,
                }
            })
        end
    }
    -- use treesitter to swap arguments
    use {
        'mizlan/iswap.nvim',
        -- '~/workspace/iswap.nvim',
        config = function ()
            require('iswap').setup({
                autoswap = true
            })
        end
    }
    -- Smart comments
    use("tpope/vim-commentary")

    -- Git integration
    -- use("tpope/vim-fugitive")
    use {
        'TimUntersberger/neogit',
        requires = 'nvim-lua/plenary.nvim',
        config = function ()
            require('neogit').setup{
                disable_builtin_notifications = true,
                disable_commit_confirmation = true
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
    
    -- Resume issues found with LSP
    use {
      "folke/trouble.nvim",
      requires = "kyazdani42/nvim-web-devicons",
      config = function()
          require("trouble").setup {}
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
    use {
        "rmagatti/alternate-toggler" 
    }

    use("kamykn/spelunker.vim")

    -- File navigation helper
    use {
        "ThePrimeagen/harpoon",
        -- config = function()
        --     require('harpoon').setup({

        --     })
        -- end
    }

    -- -- Colorscheme section
    -- use {
    --     "gruvbox-community/gruvbox",
    --     config = function()
    --         vim.cmd("colorscheme gruvbox")
    --         vim.opt.background = "dark"
    --         vim.g.gruvbox_contrast_dark = "hard"
    --     end
    -- }
    -- use "marko-cerovac/material.nvim"
    use {
        "gruvbox-community/gruvbox",
        config = function ()
            vim.opt.background = 'dark'
        end
    }
    -- use("RRethy/nvim-base16")
    -- use("kyazdani42/nvim-palenight.lua")
    -- use("folke/tokyonight.nvim")
    -- use("bluz71/vim-moonfly-colors")

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

    -- Preview HTML colors
    use("lilydjwg/colorizer")

    -- Add Sticky Buffers
    use("stevearc/stickybuf.nvim")

    -- add surround with 's'
    use {
        "ur4ltz/surround.nvim",
        config = function()
            require"surround".setup {mappings_style = "sandwich"}
        end
    }

    -- In-buffer navigation
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

    -- Ascii boxes
    -- Diagramms
    use("jbyuki/venn.nvim")
    use("gyim/vim-boxdraw")

    -- Old tab plugin
    -- use {
    --     'romgrk/barbar.nvim',
    --     requires = {'kyazdani42/nvim-web-devicons'}
    -- }
    
    -- Implement the editorconfig specification (format rules for each project)       
    use('editorconfig/editorconfig-vim')

    -- Non-LSP Language config
    -- Use emmet
    use('mattn/emmet-vim')

    -- Consider using https://github.com/danymat/neogen to easily create functions annotation (can support php docs)
    use('lumiliet/vim-twig')
    -- use('lervag/vimtex') -- tex support is already here?
    
end)


-- local map = vim.api.nvim_set_keymap
local map = vim.keymap.set

-- reload nvim config
map("n", "<Leader><Leader>r", "<cmd>source ~/.config/nvim/init.lua<CR>")

-- short cut to access system clipboard
map("n", "Y", '"+y')
map("v", "Y", '"+y')

-- little shortcut to insert new line without going into insert mode with Ctrl+Enter
map("n", "<C-Enter>", function ()
    vim.api.nvim_put({"",""}, "", true, false)
end)

-- handy little things
map("n", "<C-q>", "<Cmd>:q<CR>")
map("n", "<C-s>", "<Cmd>:w<CR>")

-- back to last buffer
map("n", "<Leader>bb", "<C-^>")

-- No highlights
map("n", "<Leader>nh", "<Cmd>noh<CR>")

-- Insert date + time
map("n", "<Leader>dt", function()
    local res = os.date("%Y-%m-%d %H:%M:%S")
    vim.api.nvim_put({res}, "", true, false)
end)

-- Insert only day date
map("n", "<Leader>dd", function()
    local res = os.date("%Y-%m-%d")
    vim.api.nvim_put({res}, "", true, false)
end)

-- using netrw
-- map("n", "<Leader>tt", "<Cmd>Explore<CR>")
-- map("n", "<Leader>th", "<Cmd>Sexplore<CR>")
-- map("n", "<Leader>tv", "<Cmd>Vexplore<CR>")

-- launch neotree
map("n", "<Leader>tt", function() vim.api.nvim_command('Neotree') end)

-- launch neogit
map("n", "<Leader>ng", function() vim.api.nvim_command('Neogit') end)

-- launch neoformat
map("n", "<Leader>nf", function() vim.api.nvim_command('Neoformat') end)

-- launch troubles
map("n", "<Leader>tr", function() vim.api.nvim_command('Trouble') end)

-- in buffer navigation
map("v", "<C-h>", function() require('tsht').nodes() end)
map("n", "<C-h>", function() require('tsht').move({ side = "start" }) end)

-- Harpoon
map("n", "<Leader>h", function() require("harpoon.ui").toggle_quick_menu() end)
map("n", "<Leader>a", function() require("harpoon.mark").add_file() end)

map("n", "<A-h>", function () require("harpoon.ui").nav_file(1) end)
map("n", "<A-j>", function () require("harpoon.ui").nav_file(2) end)
map("n", "<A-k>", function () require("harpoon.ui").nav_file(3) end)
map("n", "<A-l>", function () require("harpoon.ui").nav_file(4) end)

-- reserved for style file
-- map("n", "<A-s>", function () require("harpoon.ui").nav_file(1) end)

-- reserved for template file

-- reserved for controller file
-- map("n", "<A-s>", function () require("harpoon.ui").nav_file("Controller") end)

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

-- swap with
map("n", "<Leader>ss", function() vim.api.nvim_command('ISwap') end)
map("n", "<Leader>sw", function() vim.api.nvim_command('ISwapWith') end)
map("n", "<Leader>sl", function() vim.api.nvim_command('ISwapNodeWithLeft') end)
map("n", "<Leader>sr", function() vim.api.nvim_command('ISwapNodeWithRight') end)

-- Telescope binding
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

map("n", "<Leader>fs", function ()
  require('telescope.builtin').lsp_workspace_symbols()
end)

map("n", "<Leader>fw", function ()
  require('telescope.builtin').lsp_dynamic_workspace_symbols()
end)
-- Search for symbols accross project
-- map("n", "<Leader>fs", function ()
--   require('telescope.builtin').lsp()
-- end)


-- Treesitter config
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

-- LSP Config
local nvim_lsp = require 'lspconfig'
-- LSP Servers
local servers = { 'clangd', 'rust_analyzer', 'pyright', 'tsserver', 'gopls', 'volar' }
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
nvim_lsp.svelte.setup{
    init_options = {
        ["svelte.plugin.typescript.enable"] = false,
        ["svelte.plugin.typescript.diagnostics.enable"] = false,
    }
}
-- nvim_lsp.sumneko_lua.setup {
--   settings = {
--     Lua = {
--       runtime = {
--         -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
--         version = 'LuaJIT',
--       },
--       diagnostics = {
--         -- Get the language server to recognize the `vim` global
--         globals = {'vim'},
--       },
--       workspace = {
--         -- Make the server aware of Neovim runtime files
--         library = vim.api.nvim_get_runtime_file("", true),
--       },
--       -- Do not send telemetry data containing a randomized but unique identifier
--       telemetry = {
--         enable = false,
--       },
--     },
--   },
-- }


local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, 'lua/?.lua')
table.insert(runtime_path, 'lua/?/init.lua')

-- Cmp config
local cmp = require'cmp'

cmp.setup({
    -- enabled = function()
    --     return vim.g.hook_cmp_toggle
    --     -- let g:hook_cmp_toggle = v:true or v:false
    -- end,
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
        require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
        -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
      end,
    },
    window = {
        -- completion = cmp.config.window.bordered(),
        -- documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = {
        { name = 'nvim_lsp', keyword_length = 4 },
        { name = 'nvim_lua', keyword_length = 4 },

        { name = 'path', keyword_length = 4 },
        { name = 'treesitter', keyword_length = 4 },
        { name = "luasnip", keyword_length = 4 },
        { name = "buffer", keyword_length = 5 },
    },
    experimental = {
        -- I like the new menu better! Nice work hrsh7th
        native_menu = false,

        -- Let's play with this for a day or two
        ghost_text = false,
    },
    sorting = {
        -- TODO: Would be cool to add stuff like "See variable names before method names" in rust, or something like that.
        comparators = {
            cmp.config.compare.offset,
            cmp.config.compare.exact,
            cmp.config.compare.score,

            -- copied from cmp-under, but I don't think I need the plugin for this.
            -- I might add some more of my own.
            function(entry1, entry2)
                local _, entry1_under = entry1.completion_item.label:find "^_+"
                local _, entry2_under = entry2.completion_item.label:find "^_+"
                entry1_under = entry1_under or 0
                entry2_under = entry2_under or 0
                if entry1_under > entry2_under then
                    return false
                elseif entry1_under < entry2_under then
                    return true
                end
            end,

            cmp.config.compare.kind,
            cmp.config.compare.sort_text,
            cmp.config.compare.length,
            cmp.config.compare.order,
        },
    },
    -- sources = cmp.config.sources({
    --     { name = 'nvim_lsp' },
    --     -- { name = 'vsnip' }, -- For vsnip users.
    --     -- { name = 'luasnip' }, -- For luasnip users.
    --     -- { name = 'ultisnips' }, -- For ultisnips users.
    --     -- { name = 'snippy' }, -- For snippy users.
    -- }, {
    --         {
    --             name = 'buffer',
    --             options = {
    --                 keyword_length = 5
    --             }
    --         },
    --     })
})

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

vim.g.hook_cmp_toggle = true


-- LuaSnip config / Snippets

-- imap <silent><expr> <Tab> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<Tab>' 
-- " -1 for jumping backwards.
-- inoremap <silent> <S-Tab> <cmd>lua require'luasnip'.jump(-1)<Cr>

-- snoremap <silent> <Tab> <cmd>lua require('luasnip').jump(1)<Cr>
-- snoremap <silent> <S-Tab> <cmd>lua require('luasnip').jump(-1)<Cr>

-- " For changing choices in choiceNodes (not strictly necessary for a basic setup).
-- imap <silent><expr> <C-E> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-E>'
-- smap <silent><expr> <C-E> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-E>'
local ls = require("luasnip")

-- This replace the diagraph menu
vim.keymap.set({"i", "s"}, "<c-k>", function ()
    if ls.expand_or_jumpable() then
        ls.expand_or_jump()
    end
end)

vim.keymap.set({"i", "s"}, "<c-j>", function ()
    if ls.jumpable(-1) then
        ls.jump(-1)
    end
end)

vim.keymap.set("i", "<c-l>", function ()
    if ls.choice_active() then
        ls.change_choice()
    end
end)


-- local s = ls.snippet
-- local sn = ls.snippet_node
-- local isn = ls.indent_snippet_node
-- local t = ls.text_node
-- local i = ls.insert_node
-- local f = ls.function_node
-- local c = ls.choice_node
-- local d = ls.dynamic_node
-- local r = ls.restore_node
local events = require("luasnip.util.events")
local ai = require("luasnip.nodes.absolute_indexer")
local fmt = require("luasnip.extras.fmt").fmt
local extras = require("luasnip.extras")
local m = extras.m
local l = extras.l
local rep = extras.rep
local postfix = require("luasnip.extras.postfix").postfix

ls.add_snippets("all", {
	ls.snippet("somefoobarlel", {
		-- equivalent to "${1:cond} ? ${2:then} : ${3:else}"
		ls.insert_node(1, "cond"), ls.text_node(" ? "), ls.insert_node(2, "then"), ls.text_node(" : "), ls.insert_node(3, "else")
	}),
    ls.snippet("lorem", {
        ls.text_node("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.")
    })
})


vim.api.nvim_create_user_command('Foobar', function ()
    vim.api.nvim_put({"What?!?"}, "", true, false)
end, {})

require("luasnip.loaders.from_vscode").lazy_load()

vim.cmd("colorscheme gruvbox")
vim.g.gruvbox_contrast_dark = "hard"

