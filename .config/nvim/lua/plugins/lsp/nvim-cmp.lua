return {
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lua",
      "hrsh7th/cmp-vsnip",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-buffer",
      "hrsh7th/vim-vsnip",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-nvim-lsp-signature-help",
      "onsails/lspkind.nvim",
    },
    config = function()
      local cmp = require("cmp")

      cmp.setup({
        -- Enable LSP snippets
        snippet = {
          expand = function(args)
            vim.fn["vsnip#anonymous"](args.body)
          end,
        },
        mapping = {
          ["<Up>"] = cmp.mapping.select_prev_item(),
          ["<Down>"] = cmp.mapping.select_next_item(),
          -- Add tab support
          ["<S-Tab>"] = cmp.mapping.select_prev_item(),
          ["<Tab>"] = cmp.mapping.select_next_item(),
          ["<C-S-f>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.close(),
          ["<CR>"] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Insert,
            select = false,
          }),
        },
        -- Installed sources:
        sources = {
          { name = "path" },                    -- file paths
          { name = "nvim_lsp" },                -- from language server
          { name = "nvim_lsp_signature_help" }, -- display function signatures with current parameter emphasized
          { name = "nvim_lua" },                -- complete neovim's Lua runtime API such vim.lsp.*
          {
            name = "buffer",
            keyword_length = 3,
            entry_filter = function(entry, _)
              return require("cmp.types").lsp.CompletionItemKind[entry:get_kind()] ~= "Text"
            end,
          },
          { name = "vsnip", keyword_length = 2 }, -- nvim-cmp source for vim-vsnip
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        formatting = {
          fields = { "kind", "abbr", "menu" },
          format = require("lspkind").cmp_format({
            mode = "symbol_text",
            symbol_map = {
              File = " ",
              Module = " ",
              Namespace = " ",
              Package = " ",
              Class = " ",
              Method = " ",
              Property = " ",
              Field = " ",
              Constructor = " ",
              Enum = " ",
              Interface = " ",
              Function = " ",
              Variable = " ",
              Constant = " ",
              String = " ",
              Number = " ",
              Boolean = " ",
              Array = " ",
              Object = " ",
              Key = " ",
              Null = " ",
              EnumMember = " ",
              Struct = " ",
              Event = " ",
              Operator = " ",
              TypeParameter = " ",
            },
            maxwidth = 50,         -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
            ellipsis_char = "...", -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
          }),
        },
      })
    end,
  },
  {
    "garymjr/nvim-snippets",
    opts = {
      friendly_snippets = true,
    },
    dependencies = { "rafamadriz/friendly-snippets" },
  },
}
