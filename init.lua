-- Reuse existing Vim settings and Pathogen-managed plugins
vim.cmd([[
set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vim/vimrc
]])

-- Completion menu behaves like supertab (menu, no preselection)
vim.opt.completeopt = { "menu", "menuone", "noselect" }
vim.opt.shortmess:append("c")
vim.opt.pumheight = 12

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
})

