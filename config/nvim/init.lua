--[[

=====================================================================
==================== READ THIS BEFORE CONTINUING ====================
=====================================================================

Kickstart.nvim is *not* a distribution.

Kickstart.nvim is a template for your own configuration.
  The goal is that you can read every line of code, top-to-bottom, and understand
  what your configuration is doing.

  Once you've done that, you should start exploring, configuring and tinkering to
  explore Neovim!

  If you don't know anything about Lua, I recommend taking some time to read through
  a guide. One possible example:
  - https://learnxinyminutes.com/docs/lua/

  And then you can explore or search through `:help lua-guide`


Kickstart Guide:

I have left several `:help X` comments throughout the init.lua
You should run that command and read that help section for more information.

In addition, I have some `NOTE:` items throughout the file.
These are for you, the reader to help understand what is happening. Feel free to delete
them once you know what you're doing, but they should serve as a guide for when you
are first encountering a few different constructs in your nvim config.

I hope you enjoy your Neovim journey,
- TJ

P.S. You can delete this when you're done too. It's your config now :)
--]]
-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Install package manager
--    https://github.com/folke/lazy.nvim
--    `:help lazy.nvim.txt` for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

-- NOTE: Here is where you install your plugins.
--  You can configure plugins using the `config` key.
--
--  You can also configure plugins after the setup call,
--    as they will be available in your neovim runtime.
require('lazy').setup({
  -- NOTE: First, some plugins that don't require any configuration

  -- Git related plugins
  'tpope/vim-fugitive',

  -- Detect tabstop and shiftwidth automatically
  'tpope/vim-sleuth',

  -- automatic closing of quotes, parenthesis, brackets, etc
  'Raimondi/delimitMate',

  'vim-test/vim-test',
  'christoomey/vim-tmux-runner',

  -- NOTE: This is where your plugins related to LSP can be installed.
  --  The configuration is done below. Search for lspconfig to find it below.
  {
    -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Additional lua configuration, makes nvim stuff amazing!
      'folke/neodev.nvim',
    },
  },

  {
    'nvimdev/lspsaga.nvim',
    event = 'LspAttach',
    config = function ()
      require('lspsaga').setup({
        scroll_preview = {
          scroll_down = "<C-j>",
          scroll_up = "<C-k>",
        },
        request_timeout = 3000,
        symbol_in_winbar = {
          enable = false,
        },
        ui = {
          -- This option only works in Neovim 0.9
          title = false,
          -- Border type can be single, double, rounded, solid, shadow.
          border = "single",
          winblend = 0,
          expand = "-",
          collapse = "+",
          code_action = "💡",
          incoming = "<",
          outgoing = ">",
          hover = '',
          kind = {},
        },
      })
    end
  },

  -- motion
  { 'ggandor/leap.nvim',
    dependencies = { 'tpope/vim-repeat' },
    config = function()
      local leap = require('leap')
      leap.add_default_mappings()
    end,
  },

  {
    'simrat39/symbols-outline.nvim',
    config = function()
      require('symbols-outline').setup({
        position = 'left',
        fold_markers = { '>', 'v' },
        show_symbol_details = true,
        highlight_hovered_item = false,
        symbols = {
          File = { icon = "F", hl = "@text.uri" },
          Namespace = { icon = "N", hl = "@namespace" },
          Class = { icon = "Cls", hl = "@type" },
          Method = { icon = "m", hl = "@method" },
          Property = { icon = "$", hl = "@method" },
          Constructor = { icon = "c", hl = "@constructor" },
          Constant = { icon = "CONST", hl = "@constant" },
          Enum = { icon = "e", hl = "@type" },
          Interface = { icon = "I", hl = "@type" },
          Function = { icon = "fn", hl = "@function" },
          Variable = { icon = "$", hl = "@constant" },
          Field = { icon = "$", hl = "@field" },
          String = { icon = "str", hl = "@string" },
          Number = { icon = "num", hl = "@number" },
          Boolean = { icon = "bool", hl = "@boolean" },
          Array = { icon = "[]", hl = "@constant" },
          Operator = { icon = "+", hl = "@operator" },
          TypeParameter = { icon = "T", hl = "@parameter" },
        }
      })
    end,
  },
  {
    'saghen/blink.cmp',
    -- optional: provides snippets for the snippet source
    dependencies = { 'rafamadriz/friendly-snippets' },

    -- use a release tag to download pre-built binaries
    version = '1.*',
    opts = {
      -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
      -- All presets have the following mappings:
      -- C-space: Open menu or open docs if already open
      -- C-n/C-p or Up/Down: Select next/previous item
      -- C-e: Hide menu
      -- C-k: Toggle signature help (if signature.enabled = true)
      --
      -- See :h blink-cmp-config-keymap for defining your own keymap
      keymap = { 
        preset = 'default',
        ['<C-j>'] = { 'select_next', 'fallback' },
        ['<C-k>'] = { 'select_prev', 'fallback' },
      },

      appearance = {
        -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
        -- Adjusts spacing to ensure icons are aligned
        nerd_font_variant = 'mono'
      },

      -- (Default) Only show the documentation popup when manually triggered
      completion = { 
        documentation = { auto_show = false },
        menu = {
          auto_show = true,
        },
      },
      signature = { enabled = true, trigger = { enabled = false } },

      -- Default list of enabled providers defined so that you can extend it
      -- elsewhere in your config, without redefining it, due to `opts_extend`
      sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer' },
      },

      -- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
      -- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
      -- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
      --
      -- See the fuzzy documentation for more information
      fuzzy = { implementation = "prefer_rust_with_warning" }
    },
    opts_extend = { "sources.default" }
  },

  -- Useful plugin to show you pending keybinds.
  { 'folke/which-key.nvim', opts = {} },
  {
    -- Adds git releated signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    opts = {
      -- See `:help gitsigns.txt`
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
      on_attach = function(bufnr)
        vim.keymap.set('n', '[c', require('gitsigns').prev_hunk, { buffer = bufnr, desc = 'Go to Previous Hunk' })
        vim.keymap.set('n', ']c', require('gitsigns').next_hunk, { buffer = bufnr, desc = 'Go to Next Hunk' })
        vim.keymap.set('n', '<leader>ph', require('gitsigns').preview_hunk, { buffer = bufnr, desc = '[P]review [H]unk' })
      end
    },
  },

  {
    'mhartington/oceanic-next',
    priority = 1000,
    config = function()
      vim.cmd.colorscheme 'OceanicNext'
    end,
  },

  {
    -- Set lualine as statusline
    'nvim-lualine/lualine.nvim',
    -- See `:help lualine.txt`
    opts = {
      options = {
        icons_enabled = false,
        theme = 'OceanicNext',
        component_separators = '|',
        section_separators = '',
      },
      tabline = {
        lualine_a = {{
          'buffers',
          mode = 2,  -- show buffer name and number
          symbols = {
            modified = '+',      -- Text to show when the buffer is modified
            alternate_file = '', -- Text to show to identify the alternate file
            directory =  '/',     -- Text to show when the buffer is a directory
          }
        }},
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {}
      },
      sections = {
        lualine_a = {'branch'},
        lualine_b = {
          {'filename', path = 1, file_status = false, },
          'diff'
        },
        lualine_c = {{
          'diagnostics',
          sources = { 'nvim_diagnostic', 'nvim_lsp' },
          update_in_insert = true,
        }},
        lualine_x = {},
        lualine_y = {'progress'},
        lualine_z = {'location'}
      },
    },
  },

  -- "gc" to comment visual regions/lines
  { 'numToStr/Comment.nvim', opts = {
    mapping = { basic = true, extra = false },
  } },

  -- file finder
  'ctrlpvim/ctrlp.vim',

  -- ripgrep
  'jremmen/vim-ripgrep',

  -- Fuzzy Finder (files, lsp, etc)
  { 'nvim-telescope/telescope.nvim', branch  = '0.1.x', dependencies = { 'nvim-lua/plenary.nvim', 'nvim-telescope/telescope-live-grep-args.nvim' } },

  {
    'otavioschwanck/telescope-alternate',
    config = function()
      require('telescope-alternate').setup({
        mappings = {
          -- ocaml
          { '(.*).ml$', {{ '[1].mli', 'Module Interface' }}},
          { '(.*).mli$', {{ '[1].ml', 'Module Implementation' }}},
        },
        presets = {},
      })
    end
  },

  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" }
  },

  -- Fuzzy Finder Algorithm which requires local dependencies to be built.
  -- Only load if `make` is available. Make sure you have the system
  -- requirements installed.
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    -- NOTE: If you are having trouble with this installation,
    --       refer to the README for telescope-fzf-native for more instructions.
    build = 'make',
    cond = function()
      -- don't install on remote-dev-env
      return not is_dev_env and vim.fn.executable 'make' == 1
    end,
  },

  {
    -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
    build = ":TSUpdate",
    lazy = false,
  },

  -- NOTE: Next Step on Your Neovim Journey: Add/Configure additional "plugins" for kickstart
  --       These are some example plugins that I've included in the kickstart repository.
  --       Uncomment any of the lines below to enable them.
  -- require 'kickstart.plugins.autoformat',
  -- require 'kickstart.plugins.debug',

  -- NOTE: The import below automatically adds your own plugins, configuration, etc from `lua/custom/plugins/*.lua`
  --    You can use this folder to prevent any conflicts with this init.lua if you're interested in keeping
  --    up-to-date with whatever is in the kickstart repo.
  --
  --    For additional information see: https://github.com/folke/lazy.nvim#-structuring-your-plugins
  --
  --    An additional note is that if you only copied in the `init.lua`, you can just comment this line
  --    to get rid of the warning telling you that there are not plugins in `lua/custom/plugins/`.
  -- { import = 'custom.plugins' },
}, {
    -- don't make unintentional network calls on dev!
    install = {
      missing = false,
    },
    checker = {
      enabled = false,
    }
})

-- [[ Setting options ]]
-- See `:help vim.o`

-- Set highlight on search
vim.o.hlsearch = true

-- Make line numbers default
vim.wo.number = true

-- Enable mouse mode
vim.o.mouse = 'a'

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.o.clipboard = 'unnamedplus'

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.wo.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 50
vim.o.timeout = true
vim.o.timeoutlen = 300

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,menu,noinsert'

-- NOTE: You should make sure your terminal supports this
vim.o.termguicolors = true

-- Folds
-- vim.o.foldmethod = 'indent'
-- vim.o.foldlevelstart = 99  -- don't autoclose on read

-- Netrw
vim.g.netrw_keepdir = 0
vim.g.netrw_winsize = 30
vim.g.netrw_banner = 0
vim.g.netrw_localcopydircmd = 'cp -r'
vim.api.nvim_set_hl(0, 'netrwMarkFile', {link = 'Search'})
vim.keymap.set('n', '<C-n>', ':Lexplore<CR>', { desc = 'Toggle file explorer' })

-- [[ Basic Keymaps ]]

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- CtrlP & Ripgrep
vim.cmd([[
  function! CtrlPEnter()
    :lua require('lualine').hide({ place = {'statusline'} })
  endfunction
  function! CtrlPExit()
    :lua require('lualine').hide({ place = {'statusline'}, unhide = true })
  endfunction
]])
vim.g.ctrlp_buffer_func = {
  enter = 'CtrlPEnter',
  exit = 'CtrlPExit',
}
vim.keymap.set('n', '<leader>r', ":CtrlPMRUFiles<CR>" , { desc = 'Find in [r]ecently used files', silent = true })
vim.keymap.set('n', '<leader><space>', ":CtrlPBuffer<CR>" , { desc = 'Find in buffers', silent = true })
vim.g.ctrlp_user_command = 'rg --files %s --color=never'
vim.g.ctrlp_use_caching = 0
vim.g.ctrlp_clear_cache_on_exit = 0
vim.g.ctrlp_regexp = 0
vim.g.ctrlp_lazy_update = 0
vim.g.ctrlp_working_path_mode = 'w'
vim.g.grepprg='rg --vimgrep'
vim.g.grepformat='%f:%l:%c:%m'
vim.keymap.set('n', '<leader>f', ":Rg '<cword>' -F<CR>" , { desc = 'Find current word', silent = true })
vim.keymap.set('n', '<leader>fs', ":Rg '<cword>' -F -g '!**test**'<CR>" , { desc = 'Find current word in [s]ource, excluding tests', silent = true})
vim.keymap.set('n', '<leader>fw', ":Rg '<cword>' -F -t web<CR>" , { desc = '[F]ind current word in frontend([w]eb)', silent = true })

-- Harpoon
local harpoon = require("harpoon")
harpoon:setup()

vim.keymap.set("n", "<leader>m", function() harpoon:list():add() end)
vim.keymap.set("n", "<leader>e", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

vim.keymap.set("n", "<C-h>", function() harpoon:list():select(1) end)
vim.keymap.set("n", "<C-t>", function() harpoon:list():select(2) end)
vim.keymap.set("n", "<C-n>", function() harpoon:list():select(3) end)
vim.keymap.set("n", "<C-s>", function() harpoon:list():select(4) end)

-- Toggle previous & next buffers stored within Harpoon list
vim.keymap.set("n", "<C-S-P>", function() harpoon:list():prev() end)
vim.keymap.set("n", "<C-S-N>", function() harpoon:list():next() end)

-- [[ Configure Telescope ]]
-- See `:help telescope` and `:help telescope.setup()`
local telescope = require("telescope")
telescope.setup {
  defaults = {
    mappings = {
      i = {
        ['<C-u>'] = false,
        ['<C-d>'] = false,
      },
    },
  },
}

-- Enable telescope fzf native, if installed
pcall(telescope.load_extension, 'fzf')
pcall(telescope.load_extension, 'telescope-alternate')

-- See `:help telescope.builtin`
-- vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
-- vim.keymap.set('n', '<leader><space>', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })
-- vim.keymap.set('n', '<leader>/', function()
--   -- You can pass additional configuration to telescope to change theme, layout, etc.
--   require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
--     winblend = 10,
--     previewer = false,
--   })
-- end, { desc = '[/] Fuzzily search in current buffer' })
--
-- vim.keymap.set('n', '<C-p>', require('telescope.builtin').find_files, { desc = 'CtrlP - find file' })
-- vim.keymap.set('n', '<leader>f', function()
--   require('telescope.builtin').grep_string({
--     search = vim.fn.expand("<cword>"),
--     additional_args = {'-t','hack'}
--   })
-- end, { desc = '[F]ind current word in Hack' })
-- vim.keymap.set('n', '<leader>fs', function()
--   require('telescope.builtin').grep_string({
--     search = vim.fn.expand("<cword>"),
--     additional_args = {'-t','hack', '-g', '!**test**'}
--   })
-- end, { desc = '[F]ind current word in Hack, excluding tests' })
-- vim.keymap.set('n', '<leader>fw', function()
--   require('telescope.builtin').grep_string({
--     search = vim.fn.expand("<cword>"),
--     additional_args = {'-t','web'}
--   })
-- end, { desc = '[F]ind current word in frontend, excluding tests' })
-- vim.keymap.set('n', '<leader>fws', function()
--   require('telescope.builtin').grep_string({
--     search = vim.fn.expand("<cword>"),
--     additional_args = {'-t','web', '-g', '!**test**'}
--   })
-- end, { desc = '[F]ind current word in frontend, exclusing tests' })
-- vim.keymap.set('n', '<leader>fa',
--   require('telescope.builtin').grep_string
-- , { desc = '[F]ind current word in everything' })
--
-- vim.keymap.set('n', '<leader>lg', require('telescope.builtin').live_grep, { desc = '[L]ive [G]rep' })
-- vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })
-- vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })

-- [[ Configure Treesitter ]]
-- See `:help nvim-treesitter`
require('nvim-treesitter.configs').setup {
  -- Add languages to be installed here that you want installed for treesitter
  ensure_installed = { 
    'tsx',
    'typescript',
    'json',
    'vim',
    'lua',
    'python',
    'haskell',
    'elm',
    'javascript',
    'css',
    'ocaml',
    'markdown',
    'markdown_inline'
  },

  -- Autoinstall languages that are not installed. Defaults to false (but you can change for yourself!)
  auto_install = false,

  highlight = { enable = true },
  indent = { enable = true, disable = { 'python' } },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = '<c-space>',
      node_incremental = '<c-space>',
      scope_incremental = '<c-s>',
      node_decremental = '<M-space>',
    },
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ['aa'] = '@parameter.outer',
        ['ia'] = '@parameter.inner',
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
        ['ac'] = '@class.outer',
        ['ic'] = '@class.inner',
      },
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        [']m'] = '@function.outer',
        [']]'] = '@class.outer',
      },
      goto_next_end = {
        [']M'] = '@function.outer',
        [']['] = '@class.outer',
      },
      goto_previous_start = {
        ['[m'] = '@function.outer',
        ['[['] = '@class.outer',
      },
      goto_previous_end = {
        ['[M'] = '@function.outer',
        ['[]'] = '@class.outer',
      },
    },
  },
}

-- Diagnostic
vim.keymap.set('n', 'gdn', vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic message" })
vim.keymap.set('n', 'gdp', vim.diagnostic.goto_next, { desc = "Go to next diagnostic message" })
vim.keymap.set('n', 'go', vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })
vim.keymap.set("n", "[e", "<cmd>Lspsaga diagnostic_jump_prev<CR>")
vim.keymap.set("n", "]e", "<cmd>Lspsaga diagnostic_jump_next<CR>")
vim.keymap.set("n", "gd", "<cmd>Lspsaga show_buf_diagnostics<CR>")
vim.keymap.set("n", "gD", "<cmd>Telescope diagnostics<CR>")

vim.keymap.set('n', 'gO', '<cmd>SymbolsOutline<cr>', { desc = "toggle [O]utline" })

-- LSP
local lspconfig = require('lspconfig')

vim.api.nvim_create_autocmd('LspAttach', {

  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function (ev)
    local nmap = function(keys, func, desc)
      if desc then
        desc = 'LSP: ' .. desc
      end

      vim.keymap.set('n', keys, func, { buffer = ev.buf, desc = desc })
    end

    nmap('gR', '<cmd>Lspsaga rename<CR>', '[R]e[n]ame')
    nmap('ga', '<cmd>Lspsaga code_action<CR>', '[C]ode [A]ction')
    nmap('gl', vim.lsp.codelens.run, '[C]ode [L]enses')

    nmap('<C-]>', vim.lsp.buf.definition, '[G]oto [D]efinition')
    nmap('gd', vim.lsp.buf.declaration, '[G]oto [d]eclaration')
    nmap('gp', '<cmd>Lspsaga peek_definition<CR>', '[P]eek definition')
    nmap('gr', vim.lsp.buf.references, '[G]oto [R]eferences')
    nmap('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
    nmap('gs', vim.lsp.buf.workspace_symbol, 'find [s]ymbols in workspace')

    nmap('gci', '<cmd>Lspsaga incoming_calls<cr>', 'calls incoming')
    nmap('gco', '<cmd>Lspsaga outgoing_calls<cr>', 'calls outgoing')

    -- See `:help K` for why this keymap
    nmap('K', '<cmd>Lspsaga hover_doc<CR>', 'Hover Documentation')
    nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

    -- Highlight
    nmap('gh', vim.lsp.buf.document_highlight, '[h]ighlight')
    nmap('ghc', vim.lsp.buf.clear_references, 'clear highlight')

    -- Create a command `:Format` local to the LSP buffer
    vim.api.nvim_buf_create_user_command(ev.buf, 'Format', function(_)
      vim.lsp.buf.format()
    end, { desc = 'Format current buffer with LSP' })
    nmap('gF', vim.lsp.buf.format, '[F]ormat current buffer with LSP')

    -- auto-format before write
    -- vim.api.nvim_create_autocmd("BufWritePre", {
    --     buffer = buffer,
    --     callback = function()
    --         vim.lsp.buf.format { async = false }
    --     end
    -- })
  end
})

lspconfig.ocamllsp.setup({
  settings = {
    ocamllsp = {
      codelens = { enable = true }
    }
  },
  on_attach = function(client, bufnr)
    vim.lsp.codelens.refresh()
  end
})

-- Setup neovim lua configuration
require('neodev').setup()

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et

-- vim-test
vim.g['test#strategy'] = 'vtr'
vim.g['test#preserve_screen'] = 1
vim.g['test#echo_command'] = 0

vim.keymap.set('n', '<leader>t', ':TestNearest<CR>', { desc = 'run nearest [t]est', noremap = true, silent = true })
vim.keymap.set('n', '<leader>ts', ':TestSuite<CR>', { desc = 'run nearest [t]est[s]uit', noremap = true, silent = true })
vim.keymap.set('n', '<leader>T', ':TestFile<CR>', { desc = 'run [T]ests in file', noremap = true, silent = true })
vim.keymap.set('n', '<leader>l', ':TestLast<CR>', { desc = 're-run [l]ast test run', noremap = true, silent = true })
vim.keymap.set('n', '<leader>x', ':bd<CR>', { desc = 'close current buffer' })
vim.keymap.set('n', '<leader>n', ':bn<CR>', { desc = 'go to [n]ext buffer' })
vim.keymap.set('n', '<leader>p', ':bp<CR>', { desc = 'go to [p]revious buffer' })
for i = 1,10,1
do
  vim.keymap.set('n', '<leader>'..i, ':LualineBuffersJump! '..i..'<CR>', { desc = 'jump to buffer ' .. i, silent = true })
end
vim.keymap.set('n', '<leader>$', ':LualineBuffersJump! $<CR>', { desc = 'jump to last buffer', silent = true })

-- vtr
vim.keymap.set('n', '<leader>va', ':VtrAttachToPane<CR>', { desc = '[a]ttach to tmux pane' })
vim.keymap.set('n', '<leader>vs', ':VtrSendCommandToRunner<CR>', { desc = '[v]tr: [s]end command' })
vim.keymap.set('n', '<leader>vc', ':VtrFlushCommand<CR>', { desc = '[v]tr: [c]lear command' })
-- automatically attach to window 1
vim.api.nvim_command('autocmd VimEnter * VtrAttachToPane 1')

-- alternate file
vim.keymap.set('n', '<leader>a', '<cmd>Telescope telescope-alternate alternate_file<cr>', { desc = '[a]lternate files'})

-- endofline
vim.api.nvim_set_option('fileformat', 'unix')
vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead', 'BufWritePre' }, {
  pattern = '*',
  command = 'setl fixeol',
})

-- ROC
-- make .roc files have the correct filetype
vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
  pattern = { "*.roc" },
  command = "set filetype=roc",
})

-- add roc tree-sitter
local parsers = require("nvim-treesitter.parsers").get_parser_configs()

parsers.roc = {
  install_info = {
    url = "https://github.com/faldor20/tree-sitter-roc",
    files = { "src/parser.c", "src/scanner.c" },
  },
}
vim.o.autoread = true
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold" }, {
  command = "checktime"
})
vim.api.nvim_create_augroup("DelayedExpectReload", { clear = true })
vim.api.nvim_create_autocmd("BufWritePost", {
  group = "DelayedExpectReload",
  pattern = {"*.ml", "*.mli", "*_test.ml"},
  callback = function()
    vim.defer_fn(function()
      vim.cmd("edit")
    end, 500)  -- Adjust the delay as needed
  end,
})
