return {
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
      desc = "Open diffview",
    },
  },
}
