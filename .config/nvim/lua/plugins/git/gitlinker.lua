return {
  "ruifm/gitlinker.nvim",
  dependencies = "nvim-lua/plenary.nvim",
  keys = {
    {
      "<leader>gy",
      function()
        require("gitlinker").get_buf_range_url("n")
      end,
      desc = "Yank github permalink for this line",
    },
  },
  opts = {},
}
