return {
  "lewis6991/gitsigns.nvim",
  lazy = false,
  keys = {
    { "<leader>gp", ":Gitsigns preview_hunk<CR>", desc = "Preview hunk" },
    { "<leader>gr", ":Gitsigns reset_hunk<CR>", desc = "Reset hunk" },
    { "<leader>gB", ":Gitsigns toggle_current_line_blame<CR>", desc = "Toggle current line blame" },
    { "<leader>gR", ":Gitsigns reset_buffer<CR>", desc = "Reset buffer" },
    { "<leader>gd", ":Gitsigns diffthis<CR>", desc = "Git diff hunk under cursor" },
    { "<leader>gd", ":Gitsigns diffthis<CR>", desc = "Git diff hunk under cursor" },
    {
      "<leader>gq",
      function()
        require("gitsigns").setqflist("all")
      end,
      desc = "Dump git hunks to quickfix list",
    },
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
        { "[g", gs.prev_hunk, desc = "Previous git hunk" },
        { "]g", gs.next_hunk, desc = "Next git hunk" },
      }, { buffer = bufnr })
    end,
  },
}
