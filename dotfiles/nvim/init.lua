local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

--vim.cmd [[colorscheme onedark]]
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
vim.bo.modifiable = true

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
{ 'projekt0n/github-nvim-theme', name = 'github-theme' },
{ 'Mofiqul/dracula.nvim', name = 'dracula'},
--{ 'Sirver/ultisnips', event = { 'InsertEnter' } },
{
  'SirVer/ultisnips',
  dependencies = {
    'honza/vim-snippets',
  },
  init = function()
    vim.g.UltiSnipsSnippetDirectories = { "UltiSnips", "vim-snippets/UltiSnips" }
    vim.g.UltiSnipsExpandTrigger = '<tab>'
    vim.g.UltiSnipsJumpForwardTrigger = '<tab>'
    vim.g.UltiSnipsJumpBackwardTrigger = '<s-tab>'
  end,
},
    {
      "yetone/avante.nvim",
      event = "VeryLazy",
      version = false,
      opts = {
        provider = "ollama",
        cursor_applying_provider = 'ollama',
        behaviour = {
          enable_cursor_planning_mode = true, -- enable cursor planning mode!
        },
        ollama = {
          endpoint = "http://127.0.0.1:11434",
          model = "gemma3:4b",
        },
      },
      build = "make",
      dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "stevearc/dressing.nvim",
        "nvim-lua/plenary.nvim",
        "MunifTanjim/nui.nvim",
        "echasnovski/mini.pick",
        "nvim-telescope/telescope.nvim",
        "hrsh7th/nvim-cmp",
        "ibhagwan/fzf-lua",
        "zbirenbaum/copilot.lua",
        {
          "HakonHarnes/img-clip.nvim",
          event = "VeryLazy",
          opts = {
            default = {
              embed_image_as_base64 = false,
              prompt_for_file_name = false,
              drag_and_drop = {
                insert_mode = true,
              },
              use_absolute_path = true,
            },
          },
        },
        {
          "MeanderingProgrammer/render-markdown.nvim",
          opts = {
            file_types = { "markdown", "Avante" },
          },
          ft = { "markdown", "Avante" },
        },
      },
    },

    -- Autocompletion setup
    {
      "hrsh7th/nvim-cmp",
      event = "InsertEnter",
      dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "L3MON4D3/LuaSnip",
	"honza/vim-snippets",
	"SirVer/ultisnips",
	"quangnguyen30192/cmp-nvim-ultisnips",
        "saadparwaiz1/cmp_luasnip",
      },
      config = function()
        local cmp = require("cmp")
        cmp.setup({
          mapping = cmp.mapping.preset.insert({
            ["<Tab>"] = cmp.mapping.confirm({ select = true }),
            ["<C-Space>"] = cmp.mapping.complete(),
          }),
          sources = cmp.config.sources({
            { name = "nvim_lsp" },
            { name = "buffer" },
            { name = "path" },
	    { name = "ultisnips"},
            { name = "luasnip" },
          }),
        })
      end,
    },

    -- LSP setup
    {
      "neovim/nvim-lspconfig",
      config = function()
        local lspconfig = require("lspconfig")

        lspconfig.pyright.setup({})
        lspconfig.lua_ls.setup({
          settings = {
            Lua = {
              diagnostics = { globals = { "vim" } },
            },
          },
        })
      end,
    },
  },
  checker = { enabled = false },
})


vim.cmd [[colorscheme dracula-soft]]
