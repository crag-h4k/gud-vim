-- Neovim config (lazy.nvim + mason.nvim)
-- Uses Lua modules from this repo's `lua/` directory.
do
  local src = debug.getinfo(1, "S").source
  local this_file = (type(src) == "string" and src:sub(1, 1) == "@") and src:sub(2) or nil
  if this_file then
    -- Neovim may load this file via a symlink (e.g. ~/.config/nvim/init.lua ->
    -- ~/.vim/init.lua). Resolve the real path so we can find ~/.vim/lua/*.
    local real = (vim.loop and vim.loop.fs_realpath) and vim.loop.fs_realpath(this_file) or nil
    local roots = {
      vim.fn.fnamemodify(this_file, ":p:h"),
      real and vim.fn.fnamemodify(real, ":p:h") or nil,
    }
    for _, root in ipairs(roots) do
      if root and root ~= "" then
        package.path = package.path .. ";" .. root .. "/lua/?.lua;" .. root .. "/lua/?/init.lua"
      end
    end
  end
end
--
--
-- Oil.nvim works best with netrw disabled.
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Completion menu behaves like supertab (menu, no preselection)
vim.opt.completeopt = { "menu", "menuone", "noselect" }
vim.opt.shortmess:append("c")
vim.opt.pumheight = 12

-- Basic editor/UI settings (ported from ~/.vim/vimrc:9-57)
vim.cmd("syntax on")
vim.cmd("filetype plugin indent on")

-- Neovim always uses UTF-8 internally; keep this for parity with vimrc.
vim.opt.encoding = "utf-8"

vim.opt.wrap = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.ruler = true
vim.opt.mouse = "a"
vim.opt.clipboard = "unnamed"
vim.opt.updatetime = 500

vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.incsearch = true
vim.opt.autowrite = true
vim.opt.hidden = true

vim.keymap.set("i", "fj", "<Esc>", { noremap = true })
vim.keymap.set("c", "fj", "<Esc>", { noremap = true })

local restore_cursor_group = vim.api.nvim_create_augroup("UserRestoreCursor", { clear = true })
vim.api.nvim_create_autocmd("BufReadPost", {
  group = restore_cursor_group,
  callback = function(ev)
    local mark = vim.api.nvim_buf_get_mark(ev.buf, '"')
    local lcount = vim.api.nvim_buf_line_count(ev.buf)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
  desc = "Restore cursor to last position when reopening a file",
})

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.writebackup = false

vim.opt.backspace = { "indent", "eol", "start" }
vim.opt.wildmenu = true
vim.opt.wildmode = { "list:longest", "full" }

-- More settings ported from ~/.vim/vimrc
vim.g.python_highlight_all = 1
vim.g.pymode_indent = 0

-- Python providers (Neovim mainly uses python3, but keep both for parity)
vim.g.python_host_prog = vim.fn.expand("$HOME/.vim/venv/bin/python")
vim.g.python3_host_prog = vim.fn.expand("$HOME/.vim/venv/bin/python3")

-- Filetype overrides / additions (ported from vimrc autocmds)
local ft_group = vim.api.nvim_create_augroup("UserFiletypeOverrides", { clear = true })
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  group = ft_group,
  pattern = { "BUCK", "BUCKi" },
  command = "setfiletype starlark",
})
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, { group = ft_group, pattern = "*.go*", command = "setfiletype go" })
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, { group = ft_group, pattern = "*Dockerfile*", command = "setfiletype dockerfile" })
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  group = ft_group,
  pattern = { "*jenkinsfile*", "*Jenkinsfile*" },
  command = "setfiletype groovy",
})
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, { group = ft_group, pattern = "*.json*", command = "setfiletype json" })
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  group = ft_group,
  pattern = { "*.md*", "*.mdi" },
  command = "setfiletype markdown",
})
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, { group = ft_group, pattern = { "*.py", "*.pyi" }, command = "setfiletype python" })
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, { group = ft_group, pattern = { "*.rs", "*.rsi" }, command = "setfiletype rust" })
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, { group = ft_group, pattern = { "*.tf", "*.tfi" }, command = "setfiletype terraform" })
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  group = ft_group,
  pattern = { "*.y*ml*", "*.yaml.ig" },
  command = "setfiletype yaml",
})
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  group = ft_group,
  pattern = { "*.cfn.y*ml*", "*.template.y*ml*" },
  command = "setfiletype yaml.cloudformation",
})

-- Tabbing and indents
vim.opt.smarttab = true
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.cindent = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4

-- Tab remaps
vim.keymap.set("n", "<C-S-Enter>", "<cmd>tabe<cr>", { noremap = true })
vim.keymap.set("n", "<C-S-Tab>", "<cmd>tabp<cr>", { noremap = true })
vim.keymap.set("n", "<C-Tab>", "<cmd>tabn<cr>", { noremap = true })

-- Whitespace/listchars
vim.opt.listchars = { tab = ">-", trail = "-", nbsp = "_" }
vim.opt.list = true

-- No noise
vim.opt.errorbells = false
vim.opt.visualbell = false
vim.opt.belloff = "all"
vim.opt.timeoutlen = 500

-- Typos / helpers
vim.api.nvim_create_user_command("Q", "q", { force = true })
vim.api.nvim_create_user_command("W", "w", { force = true })
vim.api.nvim_create_user_command("WQ", "wq", { force = true })
vim.api.nvim_create_user_command("Wq", "wq", { force = true })

vim.api.nvim_create_user_command("Blanks", function()
  vim.cmd([[g/^\s*$/d]])
end, {})

vim.api.nvim_create_user_command("WS", function()
  vim.cmd([[%s/\s\+$//e]])
end, {})

vim.g.rainbow_active = 1
vim.opt.splitright = true

vim.g.LanguageClient_useVirtualText = 0

-- YAML-specific indentation tweaks
local yaml_group = vim.api.nvim_create_augroup("UserYamlFix", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
  group = yaml_group,
  pattern = "yaml",
  callback = function()
    vim.opt_local.tabstop = 2
    vim.opt_local.softtabstop = 2
    vim.opt_local.shiftwidth = 2
    vim.opt_local.expandtab = true
    vim.opt_local.indentkeys:remove("0#")
    vim.opt_local.indentkeys:remove("<:>")
  end,
  desc = "YAML indent fixes",
})

-- OPA Rego globals (for autoformat/formatter integrations)
vim.g.formatdef_rego = [["opa fmt"]]
vim.g.formatters_rego = { "rego" }
vim.g.autoformat_autoindent = 0
vim.g.autoformat_retab = 0

vim.cmd([[command! Rando g/^/exec "move " .. rand() % (line('.'))]])

-- Live diff updates
local diff_group = vim.api.nvim_create_augroup("UserDiffUpdate", { clear = true })
vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
  group = diff_group,
  callback = function()
    pcall(vim.cmd, "diffupdate")
  end,
})

-- Folding defaults
vim.opt.foldmethod = "manual"
vim.opt.foldlevelstart = 99

-- Diagnostics
vim.diagnostic.config({
  signs = {
      text = {
          [vim.diagnostic.severity.ERROR] = '☠',
          [vim.diagnostic.severity.WARN] = '⛧',
          [vim.diagnostic.severity.INFO] = 'ℹ',
          [vim.diagnostic.severity.HINT] = '☦',
      },
      numhl = {
          [vim.diagnostic.severity.WARN] = 'WarningMsg',
      },
  },
  status = true,
  underline = true,
  virtual_text = false,
  virtual_lines = false,
})

-- Statusline (Lightline)
require("statusline")

-- Bootstrap lazy.nvim (plugin manager for Neovim-only plugins)
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local servers = {
  -- LSP server IDs (must match nvim-lspconfig names)
  "bashls",
  "dockerls",
  "jinja_lsp",
  "jsonls",
  "lua_ls",
  "marksman",
  "pyright",
  "rust_analyzer",
  "terraformls",
  "yamlls",
  "gh_actions_ls"
}

require("lazy").setup({
  -- Theme (your vimrc sets :colorscheme dracula)
  { "dracula/vim", name = "dracula", lazy = false, priority = 1000 },

  -- Statusline (matches vimrc's lightline settings)
  { "itchyny/lightline.vim", lazy = false },

  -- File explorer / mass rename by editing a directory buffer
  {
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" }, -- optional, for icons
    opts = {
      default_file_explorer = true,
      view_options = { show_hidden = true },
    },
  },

  -- LSP server installer/manager
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
      "williamboman/mason.nvim",
      "hrsh7th/cmp-nvim-lsp",
      "neovim/nvim-lspconfig",
    },
    config = function()
      local mlsp = require("mason-lspconfig")
      mlsp.setup({ ensure_installed = servers })

      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      local function lua_settings()
        return { Lua = { diagnostics = { globals = { "vim" } } } }
      end
      local function build_config(server)
        local opts = { capabilities = capabilities }
        if server == "lua_ls" then
          opts.settings = lua_settings()
        end
        -- Load the server config data directly without using the deprecated lspconfig framework
        local ok, config_def = pcall(require, "lspconfig.configs." .. server)
        if not ok or not config_def or not config_def.default_config then
          vim.notify("mason-lspconfig: server not recognized by nvim-lspconfig: " .. server, vim.log.levels.WARN)
          return nil
        end
        local cfg = vim.tbl_deep_extend("force", {}, config_def.default_config, opts)
        cfg.name = cfg.name or server
        return cfg
      end

      local lsp_group = vim.api.nvim_create_augroup("UserLspAutoStart", { clear = true })

      for _, server in ipairs(servers) do
        local cfg = build_config(server)
        if cfg then
          local patterns = cfg.filetypes or "*"
          vim.api.nvim_create_autocmd("FileType", {
            group = lsp_group,
            pattern = patterns,
            callback = function(event)
              if cfg.filetypes and #cfg.filetypes > 0 then
                if not vim.tbl_contains(cfg.filetypes, vim.bo[event.buf].filetype) then
                  return
                end
              end
              vim.lsp.start(vim.tbl_deep_extend("force", {}, cfg), {
                bufnr = event.buf,
                reuse_client = function(client, config)
                  return client.name == config.name and client.config.root_dir == config.root_dir
                end,
              })
            end,
            desc = "Start LSP (" .. server .. ")",
          })
        end
        ::continue::
      end
    end,
  },

  -- Completion stack with supertab-style mappings
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "saadparwaiz1/cmp_luasnip",
      "L3MON4D3/LuaSnip",
      "rafamadriz/friendly-snippets",
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      luasnip.config.setup({})
      require("luasnip.loaders.from_vscode").lazy_load()

      local has_words_before = function()
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        if col == 0 then
          return false
        end
        local current = vim.api.nvim_get_current_line()
        return current:sub(col, col):match("%s") == nil
      end

      cmp.setup({
        preselect = cmp.PreselectMode.None,
        completion = { completeopt = "menu,menuone,noselect" },
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            elseif has_words_before() then
              cmp.complete()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
        }),
        sources = {
          { name = "nvim_lsp" },
          { name = "path" },
          { name = "buffer" },
          { name = "luasnip" },
        },
      })
    end,
  },

  -- AI chat / coding assistant
  {
    "yetone/avante.nvim",
    event = "VeryLazy",
    build = "make",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-tree/nvim-web-devicons",
      "HakonHarnes/img-clip.nvim",
      "MeanderingProgrammer/render-markdown.nvim",
    },
    opts = {
      provider = "claude",
      providers = {
        claude = {
          model = "claude-sonnet-4-6",
        },
        opus = {
          __inherited_from = "claude",
          model = "claude-opus-4-6",
        },
      },
      selector = {
        provider = "native",
      },
    },
  },
})

-- Colorscheme (ported from ~/.vim/vimrc)
vim.cmd("silent! colorscheme dracula")

-- Replace NERDTree's old <C-n> toggle with Oil
vim.keymap.set("n", "<C-n>", "<CMD>Oil<CR>", { desc = "Oil: file explorer" })
