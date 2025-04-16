return {
  "folke/which-key.nvim",
  opts = {
    delay = 300,
    icons = {
      mappings = true,
      keys = {}, -- Defaults icons to those from the nerd font
    },
    spec = {
      { "<leader>b", group = "Buffers..." },
      { "<leader>l", group = "Lsp..." },
      { "<leader>g", group = "Git..." },
      { "<leader>t", group = "Tabs..." },
      { "<leader>w", group = "Windows..." },
      { "<leader>s", group = "Search..." },
    },
  },
  keys = {
    {
      "<leader><leader>",
      ":b#<CR>",
      desc = "Go to last buffer",
    },
    {
      "<leader>bD",
      function()
        Snacks.bufdelete.all()
      end,
      desc = "Destroy all buffers",
    },
    {
      "<leader>bd",
      function()
        Snacks.bufdelete.delete()
      end,
      desc = "Destroy current buffer",
    },
    {
      "<leader>be",
      "%bd|e#<CR>",
      desc = "Destroy all except current buffer",
    },
    { "<leader>ci", ":e $MYVIMRC<CR>", desc = "Open init.lua" },
    { "<leader>tc", ":tabclose<CR>", desc = "Close the current tab" },
    { "<leader>tn", ":tabnew<CR>", desc = "Create a new tab" },
    { "<leader>wc", ":close<CR>", desc = "Close current window" },
    -- { "<leader>wh", ":sp<CR>", desc = "create a horizontal split" },
    -- { "<leader>wv", ":vsp<CR>", desc = "create a vertical split" },
    { "<Esc>", ":noh<CR>", desc = "Clear highlights" },
    {
      "[q",
      ":cp<CR>",
      desc = "Go to previous quickfix item",
    },
    {
      "]q",
      ":cn<CR>",
      desc = "Go to next quickfix item",
    },

    {
      "]t",
      ":tabnext<CR>",
      desc = "Go to next tab",
    },
    {
      "[t",
      ":tabprev<CR>",
      desc = "Go to previous tab",
    },
    {
      "cp",
      '"+y',
      desc = "Copy to clipboard",
    },
    {
      "cv",
      '"+p',
      desc = "Paste from clipboard",
    },
  },
}
