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


require('lazy').setup({
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

  -- motion
  { 'ggandor/leap.nvim',
    dependencies = { 'tpope/vim-repeat' },
    config = function()
      local leap = require('leap')
      leap.add_default_mappings()
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

      cmdline = {
        keymap = { preset = 'inherit' },
        completion = { menu = { auto_show = true } },
      },

      appearance = {
        -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
        -- Adjusts spacing to ensure icons are aligned
        nerd_font_variant = 'mono'
      },

      -- (Default) Only show the documentation popup when manually triggered
      completion = { 
        keyword = {
          range = 'prefix',
        },
        documentation = {
          auto_show = false,
          auto_show_delay_ms = 500,
        },
        menu = {
          auto_show = false,
        },
        ghost_text = {
          enabled = true,
          show_with_menu = false,
        }
      },

      signature = { enabled = true },

      -- Default list of enabled providers defined so that you can extend it
      -- elsewhere in your config, without redefining it, due to `opts_extend`
      sources = {
        min_keyword_length = 1,
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
  {
    "ibhagwan/fzf-lua",
    -- optional for icon support
    -- dependencies = { "nvim-tree/nvim-web-devicons" },
    -- or if using mini.icons/mini.nvim
    -- dependencies = { "echasnovski/mini.icons" },
    opts = {}
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

  -- ripgrep
  'jremmen/vim-ripgrep',

  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" }
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

}, {
    checker = {
      enabled = false,
    }
  })

-- [[ Setting options ]]
-- See `:help vim.o`

-- Set highlight on search
vim.o.hlsearch = true
vim.o.incsearch = true

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
vim.o.foldmethod = 'indent'
vim.o.foldlevelstart = 99  -- don't autoclose on read

-- Netrw
vim.g.netrw_keepdir = 0
vim.g.netrw_winsize = 30
vim.g.netrw_banner = 0
vim.g.netrw_localcopydircmd = 'cp -r'
vim.api.nvim_set_hl(0, 'netrwMarkFile', {link = 'Search'})
vim.keymap.set('n', '<leader>E', ':Lexplore<CR>', { desc = 'Toggle file explorer' })

-- [[ Basic Keymaps ]]

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- CtrlP & Ripgrep
vim.g.grepprg='rg --vimgrep'
vim.g.grepformat='%f:%l:%c:%m'

-- fzf
local fzf = require('fzf-lua')
vim.keymap.set('n', '<leader>r', ":FzfLua oldfiles<CR>" , { desc = 'Find in [r]ecently used files', silent = true })
vim.keymap.set('n', '<c-p>', ":FzfLua files<CR>" , { desc = 'Find files', silent = true })
vim.keymap.set('n', 'gd', ':FzfLua diagnostics_document<CR>', { desc = 'buffer diagnostics', silent = true })
vim.keymap.set('n', 'gD', ':FzfLua diagnostics_workspace<CR>', { desc = 'workspace diagnostics', silent = true })
vim.keymap.set('n', '<leader>F', ':FzfLua global<CR>', {desc = 'Fzf global', silent = true })
vim.keymap.set('n', '<leader>s', ":FzfLua live_grep<CR>", { desc = 'search for word'})
vim.keymap.set('n', '<leader>f', ":FzfLua grep_cword<CR>", { desc = 'find current word', silent = true })
vim.keymap.set('n', '<leader>fl', ':FzfLua resume<CR>', {desc = 'Fzf resume', silent = true })
vim.keymap.set('n', '<leader>fs', ':FzfLua spell_suggest<CR>', {desc = 'Spell suggest', silent = true })
vim.keymap.set('n', '<leader>fk', ':FzfLua keymaps<CR>', {desc = 'Fzf keymaps', silent = true })
vim.keymap.set('n', '<leader>fh', ':FzfLua helptags<CR>', {desc = 'Fzf helptags', silent = true })
vim.keymap.set('n', '<leader>fb', ':FzfLua builtin<CR>', {desc = 'Fzf builtin', silent = true })
fzf.setup({
  "hide",
  keymap = {
    builtin = {
      ['<c-n>'] = 'preview-page-down',
      ['<c-p>'] = 'preview-page-up',
    },
    fzf = {
      true,
      -- Use <c-q> to select all items and add them to the quickfix list
      ["ctrl-q"] = "select-all+accept",
    }
  },
  files = {
    git_icons = false,
    file_icons = false,
    color_icons = false,
  },
  git = {
    files = {
      git_icons = false,
      file_icons = false,
      color_icons = false,
      silent = true,
    }
  },
  grep = {
    git_icons = false,
    file_icons = false,
    color_icons = false,
    rg_glob = true,
    RIPGREP_CONFIG_PATH = vim.env.RIPGREP_CONFIG_PATH
  },
  oldfiles = {
    git_icons = false,
    file_icons = false,
    color_icons = false,
    include_current_session = true,
  },
  lsp = {
    async = true,
    file_icons = false,
    symbols = {
      symbol_style = 3,  -- kind only
    }
  }
})
fzf.register_ui_select()

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

-- [[ Configure Treesitter ]]
-- See `:help nvim-treesitter`
require('nvim-treesitter.configs').setup {
  -- Add languages to be installed here that you want installed for treesitter
  ensure_installed = { 
    'tsx',
    'gleam',
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

-- LSP
local lspconfig = require('lspconfig')
vim.keymap.set('n', '<leader>lr', ':LspRestart<CR>', { desc = 'restart LSP' })

vim.api.nvim_create_autocmd('LspAttach', {

  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function (ev)
    local nmap = function(keys, func, desc)
      if desc then
        desc = 'LSP: ' .. desc
      end

      vim.keymap.set('n', keys, func, { buffer = ev.buf, desc = desc })
    end

    nmap('gR', vim.lsp.buf.rename, '[R]e[n]ame')
    nmap('ga', '<cmd>FzfLua lsp_code_actions<CR>', '[C]ode [A]ction')
    nmap('gl', vim.lsp.codelens.run, '[C]ode [L]enses')

    nmap('<C-]>', vim.lsp.buf.definition, '[G]oto [D]efinition')

    nmap('gr', '<cmd>FzfLua lsp_references<cr>', 'Find references')
    nmap('gd', '<cmd>FzfLua lsp_declarations<cr>', 'Find references')
    nmap('gI', '<cmd>FzfLua lsp_implementations<cr>', '[G]oto [I]mplementation')
    nmap('gs', '<cmd>FzfLua lsp_document_symbols<cr>', '[s]ymbols in document')
    nmap('gS', '<cmd>FzfLua lsp_workspace_symbols<cr>', '[S]ymbols in workspace')
    nmap('gci', '<cmd>FzfLua lsp_incoming_calls<cr>', 'calls incoming')
    nmap('gco', '<cmd>FzfLua lsp_outgoing_calls<cr>', 'calls outgoing')

    -- See `:help K` for why this keymap
    nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
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
    --   buffer = buffer,
    --   callback = function()
    --     vim.lsp.buf.format { async = false }
    --   end
    -- })
  end
})

if vim.fs.basename(vim.fn.getcwd()) == "golden-sheaf" then
  vim.lsp.config['ocamllsp'] = {
    cmd = { 'make', 'dev-lsp' },
  }
else
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
end
vim.lsp.enable('ocamllsp')
vim.g.no_ocaml_maps = 1

vim.lsp.config('tailwindcss', {
  settings = {
    tailwindCSS = {
      classAttributes = { "class_" },
      includeLanguages = {
        ocaml = "html"
      }
    }
  }
})
vim.lsp.enable('tailwindcss')
vim.lsp.enable('gleam')

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
vim.keymap.set('n', '<leader>c', function()
  vim.cmd('write')
  local buf_name = vim.api.nvim_buf_get_name(0)
  local line_num = vim.api.nvim_win_get_cursor(0)[1]
  local msg = string.format("Please complete the task at %s:%d", buf_name, line_num)
  vim.cmd('VtrAttachToPane 2')
  vim.cmd('VtrSendCommand ' .. vim.fn.shellescape(msg))
end, { desc = '[c]all opencode to complete task' })

for i = 1,10,1
  do
  vim.keymap.set('n', '<leader>'..i, ':LualineBuffersJump! '..i..'<CR>', { desc = 'jump to buffer ' .. i, silent = true })
end
vim.keymap.set('n', '<leader>$', ':LualineBuffersJump! $<CR>', { desc = 'jump to last buffer', silent = true })

-- vtr
vim.keymap.set('n', '<leader>va', ':VtrAttachToPane<CR>', { desc = '[a]ttach to tmux pane' })
vim.keymap.set('n', '<leader>vs', ':VtrSendCommandToRunner<CR>', { desc = '[v]tr: [s]end command' })
vim.keymap.set('n', '<leader>vc', ':VtrFlushCommand<CR>', { desc = '[v]tr: [c]lear command' })
-- automatically attach to window 2
vim.api.nvim_command('autocmd VimEnter * VtrAttachToPane 2')


vim.opt.scrolloff = 23
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
