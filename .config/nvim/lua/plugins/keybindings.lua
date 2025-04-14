return {
  "folke/which-key.nvim",
  opts = {
    delay = 300,
    icons = {
      mappings = true,
      keys = {}, -- Defaults icons to those from the nerd font
    },
    spec = {
      { "<leader>b", group = "buffers..." },
      { "<leader>l", group = "lsp..." },
      { "<leader>g", group = "git..." },
      { "<leader>t", group = "tabs..." },
      -- { "<leader>w", group = "windows..." },
      { "<leader>f", group = "find..." },
    },
  },
  keys = {
    {
      "<leader><leader>",
      ":b#<CR>",
      desc = "go to last buffer",
    },
    {
      "<leader>bD",
      function()
        Snacks.bufdelete.all()
      end,
      desc = "destroy all buffers",
    },
    {
      "<leader>bd",
      function()
        Snacks.bufdelete.delete()
      end,
      desc = "destroy current buffer",
    },
    {
      "<leader>be",
      "%bd|e#<CR>",
      desc = "destroy all except current buffer",
    },
    { "<leader>ci", ":e $MYVIMRC<CR>", desc = "open init.lua" },
    { "<leader>tc", ":tabclose<CR>", desc = "close the current tab" },
    { "<leader>tn", ":tabnew<CR>", desc = "create a new tab" },
    { "<leader>wc", ":close<CR>", desc = "close current window" },
    -- { "<leader>wh", ":sp<CR>", desc = "create a horizontal split" },
    -- { "<leader>wv", ":vsp<CR>", desc = "create a vertical split" },
    { "<Esc>", ":noh<CR>", desc = "clear highlights" },
    {
      "[q",
      ":cp<CR>",
      desc = "go to previous quickfix item",
    },
    {
      "]q",
      ":cn<CR>",
      desc = "go to next quickfix item",
    },

    {
      "]t",
      ":tabnext<CR>",
      desc = "go to next tab",
    },
    {
      "[t",
      ":tabprev<CR>",
      desc = "go to previous tab",
    },
  },
}
