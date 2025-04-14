return {
  {
    "lewis6991/gitsigns.nvim",
    lazy = false,
    keys = {
      { "<leader>gp", ":Gitsigns preview_hunk<CR>", desc = "preview hunk" },
      { "<leader>gr", ":Gitsigns reset_hunk<CR>", desc = "reset hunk" },
      { "<leader>gB", ":Gitsigns toggle_current_line_blame<CR>", desc = "toggle current line blame" },
      { "<leader>gR", ":Gitsigns reset_buffer<CR>", desc = "reset buffer" },
      { "<leader>gd", ":Gitsigns diffthis<CR>", desc = "git diff hunk under cursor" },
    },
    opts = {
      signs = {
        add = { text = "▎" },
        change = { text = "▎" },
        delete = { text = "" },
        topdelete = { text = "" },
        changedelete = { text = "▎" },
        untracked = { text = "▎" },
      },
      signs_staged = {
        add = { text = "▎" },
        change = { text = "▎" },
        delete = { text = "" },
        topdelete = { text = "" },
        changedelete = { text = "▎" },
      },
      current_line_blame = true,
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns
        require("which-key").add({
          { "[g", gs.prev_hunk, desc = "previous git hunk" },
          { "]g", gs.next_hunk, desc = "next git hunk" },
        }, { buffer = bufnr })
      end,
    },
  },
  {
    "tpope/vim-fugitive",
    keys = {
      { "<leader>gm", ":Git mergetool<CR>", desc = "populate quickfix with merge conflicts" },
      { "<leader>gb", ":Git blame<CR>", desc = "blame this buffer" },
    },
  },
  {
    "ruifm/gitlinker.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    keys = {
      {
        "<leader>gy",
        function()
          require("gitlinker").get_buf_range_url("n")
        end,
        desc = "yank github permalink for this line",
      },
    },
    opts = {},
  },
  {
    "sindrets/diffview.nvim",
    lazy = false,
    opts = {},
    keys = {
      {
        "<leader>d",
        function()
          if next(require("diffview.lib").views) == nil then
            vim.cmd("DiffviewOpen")
          else
            vim.cmd("DiffviewClose")
          end
        end,
        desc = "open diffview",
      },
    },
  },
}
