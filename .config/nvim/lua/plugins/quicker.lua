return {
  "stevearc/quicker.nvim",
  event = "FileType qf",
  opts = {
    opts = {
      number = true,
    },
    type_icons = {
      E = " ",
      W = " ",
      I = " ",
      N = " ",
      H = "󰌵 ",
    },
  },
  keys = {
    {
      "R",
      function()
        require("quicker").refresh()
      end,
      desc = "Toggle qflist",
    },
    {
      "<leader>q",
      function()
        require("quicker").toggle()
      end,
      desc = "Toggle qflist",
    },
    {
      ">",
      function()
        require("quicker").expand({ before = 2, after = 2, add_to_existing = true })
      end,
      desc = "Expand quickfix context",
    },
    {
      "<",
      function()
        require("quicker").collapse()
      end,
      desc = "Collapse quickfix context",
    },
  },
}
